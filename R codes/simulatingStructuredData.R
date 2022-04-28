#Simulating structured data for the case of party aspirin and headache: P -> A; P-> H; A -> H
library(rethinking)

n <- 10#no of group
m <- 20#no of friends in a group

#group id
f <- rep(1:n, each = m)

#party or no party for the group n instead of the individual
p <- rbinom(n,1,0.5)

#aspirin influenced by the party p[f]
a <- rbinom(n*m, 1, ifelse(p[f],0.9,0.1)) #need to access correct party at the index

mu <- -0.3 + (0.3 * p[f]) - (0.2 * a)
sigma <- 0.07

h <- rnorm(n*m, mu, sigma)

model <- ulam(alist(
  h ~ dnorm(mu,sigma),
  mu <- b * a + p[f],
  
  p[f] ~ dnorm(0,1),
  b ~ dnorm(0,1),
  sigma ~ dunif(0,1)
), data = list(h = h, a = a, f=f, n=n, m=m))

stancode(model)
samples <- extract.samples(model)

hist(samples$b)
