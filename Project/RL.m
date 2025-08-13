env = MyEnvironment;
validateEnvironment(env);

opt = rlTrainingOptions(...
    MaxEpisodes=500,...
    MaxStepsPerEpisode=500,...
    StopTrainingCriteria="AverageReward",...
    StopTrainingValue=0);
trainResults = train(agent,env,opt);

% trainResults = train(agent,env,trainResults);

% trainResults.TrainingOptions.MaxEpisodes = 2000;
% trainResults.TrainingOptions.Plots = "none";
% trainResults.TrainingOptions.Verbose = 1;
% trainResultsNew = train(agent,env,trainResults);
