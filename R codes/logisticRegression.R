#Simulating Logistic data
library(rethinking)
library(rstan)
n <- 200

#weight

w <- rnorm(n, mean = 70, sd = 10)

prob <- 1 / (1 + exp(-(-13 + 0.2 * w)))

#Chances of getting covid

c <- rbinom(n, size = 1, prob = prob)

plot(c)

model <- ulam(alist(
  c ~ bernoulli_logit(a + b * w),
  
  a ~ dnorm(mean = 0, sd =2),
  b ~ dnorm(mean=0,sd=2)
), data = list(n=n, w=w, c=c))


model1 <- stan(model_code = "
           data{
        int<lower=0> n;
        vector[n] w;
        int<lower=0,upper=1> c[n];
        }
        parameters{
        real alpha;
        real beta;
        }
        model{
        c ~ bernoulli_logit(alpha + beta * w);
        }
    ", data = list(n=n, w=w, c=c), chains = 1)

samples1 <- extract(model1)

samples <- extract.samples(model)

hist(samples$b)
hist(samples1$beta)
hist(samples$a)
