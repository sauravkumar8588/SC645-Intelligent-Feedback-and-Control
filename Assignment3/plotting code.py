import numpy as np 
import matplotlib.pyplot as plt

x = [0, 0.5, 1, 1.25]
y = [3.53, 2.7, 1.95, 1.59]
y1 = [0.025, 0.0183, 0.0126, 0.0101]

plt.plot(x, y1)
plt.xlabel('temperature')
plt.ylabel('Delay Margin in second')
plt.title('Delay Margin trend with T')
plt.show()
