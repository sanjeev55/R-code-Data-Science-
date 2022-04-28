k <- 1
range <- 1
while (k <= 4)
{
  Y <- c(1,2,3,4,5,6,7,8)
  start <- range
  end <- range + 1
  Ytest <- Y[(start:end)]
  Y <- Y[-c(start:end)]
  print(Ytest)
  print(Y)
  k = k + 1
  
  range <- end + 1
}

