#Hamiltoninan MOnte Carlo
library(rstan)
library(rethinking)
D <- c(0.312, 0.555, 0.24, 0.979)

model <- ulam(alist(
  D ~ dnorm(mu, sigma),
  
  mu ~ dnorm(0,1),
  sigma ~ dnorm(0,1)
), data = list(D=D))

samples <- extract.samples(model)
plot(samples$sigma, samples$mu, pch = 16, col = rgb(0, 0, 0, 0.4))
