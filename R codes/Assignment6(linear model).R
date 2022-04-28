library(rethinking)

df <- read.csv('data.csv')

w <- df$weight
h <- df$height
age <- df$age
ageBar <- mean(age)
age2 <- age^2
age2Bar <- mean(age2)
age3 <- age^3
age3Bar <- mean(age3)


plot(age, h, xlab = 'Age', ylab = 'Height')

#lines
model <- ulam(alist(
  h ~ dnorm(mu, sigma),
  mu <- a + b * (age - ageBar),
  a ~ dnorm(178,20),
  b ~ dnorm(0,10),
  sigma ~ dunif(0,50)
), data = list(h = h, age = age, ageBar = ageBar ))

samples <- extract.samples(model)

for (i in 1:100){
  a <- samples$a[i]
  b <- samples$b[i]
  
  
  mu <- a + b * (age - ageBar)
  lines(age, mu, col = rgb(0, 1, 0, 0.2))
}
  
#curves

model1 <- ulam(alist(
  h ~ dnorm(mu, sigma),
  a ~ dnorm(178,20),
  b1 ~ dnorm(0,10),
  b2 ~ dnorm(0,10),
  b3 ~ dnorm(0,10),
  mu <- a + b1 * (age) + b2 * (age2) + b3 * (age3),
  sigma ~ dunif(0,50)
), data = list(h=h, age=age, age2 = age2, age3 = age3))

samples1 <- extract.samples(model1)
ages <- seq(0, 100, length.out = 60)
for (i in 1:100){
  a <- samples1$a[i]
  b1 <- samples1$b1[i]
  b2 <- samples1$b2[i]
  b3 <- samples1$b3[i]
  
  
  mu <- a + b1 * (ages) + b2 * (ages^2) + b3 * (ages^3)
  lines(ages, mu, col = rgb(1, 0, 0, 0.2))
}
