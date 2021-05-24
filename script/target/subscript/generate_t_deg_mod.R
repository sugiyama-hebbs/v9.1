## Generate a random target-direction modifier

num_tmod <- length(tmod_v) # number of modifying direction

# Randomize within each "chunk" so that there won't be a chunk of the same rotation by chance after randomization 
t_deg_mod = rep(0,num_tri) # Initialize
num_rep =  num_tri/length(tmod_v) # number of trials per one mod value

idx = 1
for (cyc in 1:num_rep){
  t_deg_mod[idx:(idx+num_tmod-1)] = tmod_v[sample(1:num_tmod)]
  idx = idx+num_tmod
}

# fill last few trials when the total number of trials cannot be divided by the number of tmod.
if (num_tri%%num_tmod != 0){
  remaining_tri <- idx:num_tri
  t_deg_mod[remaining_tri] <- sample(tmod_v, length(remaining_tri))
  warning("Total number of trial cannot be divided by the number of target directions. The number of trials is not the same across target directions")
} 



