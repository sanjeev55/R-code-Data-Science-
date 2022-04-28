#Grid approximation
#Simulation of data
library(rethinking)#for ulam
set.seed(1)
n <- 18
D <- rbinom(n,1,0.2)

#################################
#modelling using ulam
model <- ulam(list(
  D ~ dbinom(1,prob),
  prob ~ dunif(0,1)
), data = list(D=D))

stancode(model)#gives the stan code for the model

samples1 <- extract.samples(model)
hist(samples1$prob)
#######################

###################################
#modeling
probs <- seq(0,1,length.out = 200)

likelihoods <- sapply(probs, function(x){
  return(prod(dbinom(D,1,x)))
})

plot(probs,likelihoods, type='l')


#Grid approx + prior = posterior

prior <- dbeta(probs, 4, 4)

posterior <- prior * likelihoods

samples <- sample(probs, prob = posterior, size = 1e4, replace = T)
hist(samples)

#-----------------answering questions------------------
#intervals of defined boundaries; finding posterior values lying within 0.4 probs
print(sum(samples < 0.4)/length(samples))

#defined probability mass
quantile(samples)

#point estimates
chainmode(samples, adj = 0.01)
#------------------------------------------------


#with prior
plot(probs, posterior, type = 'l', col = 'red')

#without prior
lines(probs, likelihoods)
#########################################
