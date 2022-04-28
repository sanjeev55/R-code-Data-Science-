import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import poisson
from scipy.stats import uniform
from scipy.stats import norm

np.random.seed(100)

# calculating posteriors using grid approximation
lambdas = np.linspace(0, 4, num=101)
Y = np.array([0, 0, 1, 2, 0, 2, 2, 1, 1])
priors = uniform.pdf(lambdas, 0, 4)
likelihoods = [np.prod(poisson.pmf(k=Y, mu=lamb)) for lamb in lambdas]
posteriors = np.multiply(priors, likelihoods)
posteriors = posteriors/np.sum(posteriors)
print(posteriors)


# sampling via Metropolis-Hastings algorithm

# taking first random sample
x = np.random.uniform(0, 4)
samples = np.array([x])

# generating 2000 samples
for _ in range(1, 2000):
    x_bar = np.random.uniform(0, 4) #next sample
    x_prob = uniform.pdf(x, 0, 4)*np.prod(poisson.pmf(k=Y, mu=x)) #current sample probability
    x_bar_prob = uniform.pdf(x_bar, 0, 4)*np.prod(poisson.pmf(k=Y, mu=x_bar)) #next sample probability
    alpha = np.random.uniform(0, 1)
    x = x_bar if alpha <= x_bar_prob/x_prob else x #decision whether to accept next sample
    samples = np.append(samples, x)
print(samples)


# plotting the results
plt.plot(lambdas, posteriors*25)
plt.hist(samples, density=True)
plt.xlabel('Lambda values')
plt.title('Distribution of the relative likelihood for the values of parameter \'lambda\'')
plt.legend(labels=['Metropolis-Hastings samples', 'Grid approximation posterior'])
plt.show()
