%discrete input values
actionValues = -20:2:20; 
actInfo = rlFiniteSetSpec(actionValues);
actInfo.Name = 'action';

obsInfo = rlNumericSpec([2 1]);
obsInfo.Name = 'state';  % Name of observation

% Define the actor network
actorNetwork = [
    featureInputLayer(2, 'Normalization', 'none', 'Name', 'state')  % Ensure 'Name' matches observation names
    fullyConnectedLayer(32, 'Name', 'fc1')
    reluLayer('Name', 'relu1')
    fullyConnectedLayer(32, 'Name', 'fc2')
    reluLayer('Name', 'relu2')
    fullyConnectedLayer(numel(actionValues), 'Name', 'fcOutput')  % Output size matches number of discrete actions
    % softmaxLayer('Name', 'output')  % Use softmax layer for probability distribution over actions
];

% Define the critic network
criticNetwork = [
    featureInputLayer(2, 'Normalization', 'none', 'Name', 'state')  % Make sure 'Name' matches observation names
    fullyConnectedLayer(32, 'Name', 'fc1')
    reluLayer('Name', 'relu1')
    fullyConnectedLayer(32, 'Name', 'fc2')
    reluLayer('Name', 'relu2')
    fullyConnectedLayer(1, 'Name', 'value')  % Output a single value for state value
];

% Specify the options for the actor
% actorOptions = rlRepresentationOptions('LearnRate',1e-02,'GradientThreshold',1);

% Setup the actor representation for discrete actions
actor = rlDiscreteCategoricalActor(actorNetwork, obsInfo, actInfo);

% Options for the critic network
% criticOptions = rlRepresentationOptions('LearnRate',1e-04,'GradientThreshold',1);

% Setup the critic representation
critic = rlValueFunction(criticNetwork, obsInfo);

% PPO agent options
agentOpts = rlPPOAgentOptions(...
    'SampleTime', 0.02, ...
    'DiscountFactor', 0.99, ... 
    'ExperienceHorizon', 2048, ...
    'ClipFactor', 0.2, ...
    'EntropyLossWeight', 0.01, ...
    'MiniBatchSize', 64, ...
    'NumEpoch', 10, ...
    'AdvantageEstimateMethod', 'gae', ...
    'GAEFactor', 0.95);

% Create the PPO agent
agent = rlPPOAgent(actor, critic, agentOpts);
