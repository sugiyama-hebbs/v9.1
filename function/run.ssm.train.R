# Run state-space model and return the results.
# This is for data in Train phase where estimated sensory prediction error is used instead of performance error 
# (because we cannot calculate performance error in S trials)
#
#### Model ####
## u(k) = PTB(k) - x(k) # error as input 
## x(k+1) = ax(k) + bu(k) # update x
## 
#### input ####
## param: a vector containing model parameters (a,b,x0)
##        a: retention rate
##        b: learning rate
##        x0: initial value
## 
## data: a dataframe with the following observable data
##       tgt: target direction
##       err: estimated sensory prediction error
##       hand: hand direction
#### output ####
## results: a list containing
##       param, data: function inputs
##       x: estimated latent variable (typically memory of perturbation in visuomotor task)
##       est_hand: estimated output (hand direction)
##       r2: coefficient of determination
##       rmse: root mean squared error
##
#### Authour ####
## Taisei Sugiyama

run.ssm.train <- function(param = NA, data) {
  
  # Do some preparation
  if (is.na(param)){ # parameter is included in data
    a = data$alpha[1]
    b = data$beta[1]
    x0 = data$x0[1]
    
  } else { # parameter is supplied
    a = param[1]
    b = param[2]
    x0 = param[3]
  }
  
  tgt = data$tgt
  # cur = data$cur
  hand = data$hand
  err = data$est_spe
  
  num_tri = length(tgt) # number of trials (time steps)
  x = vector(mode="integer", length = num_tri) # initialize
  u = vector(mode="integer", length = num_tri) # initialize
  
  x[1] = x0 
  
  # Get model estimate
  for (tri in 1:num_tri){
    
    # Temporarily substitute NA data with tgt direction (so treating it as 0 input)
    if (is.na(hand[tri])) { 
      # cur[tri] = tgt[tri]
      hand[tri] = tgt[tri]
      u[tri] = 0 # assume no input (and no update)
    }
    
    u[tri] = err[tri] # Performance error
    if (tri != num_tri)
      x[tri+1] = a*x[tri] + b*u[tri] # Update x
  }
  
  est_hand = tgt - x # estimated hand. assume tgt = hand + x 
  
  hand_align = hand - (tgt - 90) # aligned to 90 degree-tgt
  
  r2 = 1 - sum((hand-est_hand)^2)/sum((hand_align-mean(hand_align))^2)
  
  if (r2 < 0){
    r2 = 0
  }
  
  
  rmse = sqrt(mean((x - (tgt-hand))^2, na.rm = TRUE)) # root mean squared error
  
  results = list(param = param, data = data, x = x, est_hand = est_hand, r2 = r2, rmse = rmse)
  
  return(results)
}