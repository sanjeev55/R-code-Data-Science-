library(rethinking)

#relation between time, salary and job satisfaction

#simulating the scenario where high salary causes high job satisfaction with observed co variant of time to travel 
#and time depends on salary as well
n <- 1000

#salary m = 0, sd = 1
s <- rnorm(n)

#time to travel 
t <- rnorm(n, mean = -s)

#job satisfaction is increased by the factor of 1 by high salary and decreased by the factor of 1 by high time to travel
mu <- 0 + (1 * s) + (-1 * t) 
sigma <- 1

j <- rnorm(n, mu, sigma)

print(round(data.frame(s=s, t=t, j=j),2))

#ulam code for model for the data

model <- ulam(alist(
  j ~ dnorm(mu,sigma),
  mu <- a + (bs * s) + (bt * t),
  
  a ~ dnorm(0,1),
  bs ~ dnorm(0,1),
  bt ~ dnorm(0,1),
  sigma ~ dunif(0,3)
), data = list(s = s, t = t, j = j))


samples <- extract.samples(model)

hist(samples$bs)
hist(samples$bt)
hist(samples$a)

plot(samples$bs, samples$bt)

