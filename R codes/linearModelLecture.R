library(stan)
library(rethinking)
n <- 1000

#possible parameters
mu <- rnorm(n, 178,20)
sigma <- runif(n,0,50)

h <- rnorm(n,mu,sigma)

hist(h)

#using ulam

model <- ulam(alist(
  h ~ dnorm(mu,sigma),
  mu ~ dnorm(178,20),
  sigma ~ dunif(0,50)
), data = D)
