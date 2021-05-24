## Create a vector of random numbers and save into csv file. 
# This version generates numbers from normal distribution, centering at 0 and sd of 1.0 
# This generates pairs (two columns) of random values, as it is planned to be used for varying 2d data (x and y)
# Author: Taisei Sugiyama


rm(list = ls()) # clear current workspace just in case
set.seed(123456)

#### Set key values ####

num_rand <- 10000
rand_val1 <- rnorm(num_rand,mean = 0, sd = 1)
rand_val2 <- rnorm(num_rand,mean = 0, sd = 1)

rand_val <- cbind(rand_val1,rand_val2)

  
write.table(rand_val,sprintf("script/target/randn_normal.csv"),
              row.names = F, col.names = F, sep = " ")
  

