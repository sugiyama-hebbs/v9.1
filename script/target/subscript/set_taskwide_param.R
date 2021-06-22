# Set task-wide parameters (parameters that are the same across the entire task)
t_deg_ref <- 90 # reference target direction (if target direction is adjusted, the adjustment is made with respect to this direction)
t_radius_ref <- 0.1 # reference target radius (m)
wait_min <- 600 # minimum wait time (ms)
addwait_max <- 600 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  
wait_min_mod <- 800 # minimum wait time (ms)
addwait_max_mod <- 600 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  
addwait_max_mod2 <- 300 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  


wait_min_mod2 <- 800 # minimum wait time (ms)
addwait_max_mod3 <- 400 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  


spc <- 1 # s trial per cycle
mpc <- 4 # m trial per cycle
cpb <- 30 # cycles per block

# for task-error version
spc_te <- 1 # s trial per cycle
mpc_te <- 1 # m trial per cycle

spc_te_9.11 <- 1 # s trial per cycle
mpc_te_9.11 <- 4 # m trial per cycle


spc_te_9.12 <- 6 # s trial per cycle
mpc_te_9.12 <- 1 # m trial per cycle

cpb_te <- 60 # cycles per block
cpb_te_vary_rot <- 16 # cycles per block
cpb_te_short <- 30 # cycles per block
cpb_te_9.14 <- 10 # cycles per block
cpb_te_9.25 <- 50 # cycles per block
cpb_te_9.25_mod <- 40 # cycles per block
cpb_te_9.27 <- 40 # cycles per block
cpb_te_9.28 <- 48 # cycles per block
cpb_te_9.286 <- 24 # cycles per block
cpb_te_9.11 <- 16
cpb_te_9.12 <- 12
cpb_te_9.13 <- 20
cpb_9.2 <- 10 # cycles per block