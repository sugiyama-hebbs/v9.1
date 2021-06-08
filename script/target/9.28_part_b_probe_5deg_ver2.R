## Generate a sequence file (.tgt) for v8.1
#
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)


rm(list = ls()) # clear current workspace, just in case

# Use the original seed
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
# format: sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id)
version_id = "9.28" # version id
blk_tags <- 0 # block tag
cond <- "probe_part_5deg_ver2" # condition. Also the main part of filename
pre_tag <- ""
pos_tag <- ""

## Task-related
source("script/target/subscript/set_taskwide_param.R") # set task-wide parameters

rot_size <- 5 # visual rotation size (degree)
# tpc <- spc + mpc # trials per cycle

ph0 = 0 # trials in phase 0 (Familiarization/Pre-training)
ph1 = 0 # trials in phase 1 (initial washouts in main blocks)
ph2 = 0 # trials in phase 2 (Pre-Probe)
ph3 = 0 # trials in phase 3 (washouts before Train)
ph4 = 0 # trials in phase 4 (Train)
ph5 = 0 # trials in phase 5 (Post-Train Washout)
ph6 = 25 # trials in phase 6 (Post-Probe)
ph7 = 0 # trials in phase 7 (visuomotor)
ph8 = 0 # trials in phase 8 (reward-based)
ph9 = 0 # trials in phase 9 (extra)

blk_phase <- c(rep(0,ph0),rep(1,ph1),rep(2,ph2),rep(3,ph3),rep(4,ph4),rep(5,ph5),rep(6,ph6),rep(7,ph7),rep(8,ph8),rep(9,ph9))
num_tri <- ph0 + ph1 + ph2 + ph3 + ph4 + ph5 + ph6 + ph7 + ph8 + ph9

min_score <- rep(0,num_tri)  
max_score <- rep(0,num_tri) 
difficulty <- rep(1,num_tri)

train_type <- rep(0,num_tri)

s_tri <- rep(1,num_tri) # flag s trial
m_tri <- rep(0,num_tri)  # flag m trial

rot_pattern <- c(rep(0,10),rep(1,10),rep(0,5)) # apply rotation on last 20 trials (10 cycles), whatever precedes them will be "washouts" (no rotation) 

# initialize
show_arc <- rep(0,num_tri)
show_cur <- rep(0,num_tri)  
trial_type <- rep(0,num_tri) 
rot_degree <- rep(0,num_tri)
show_score <- rep(0,num_tri)

# assign appropriate values to each type of trial
rot_degree <- rot_size*rot_pattern
show_arc[s_tri == 1] <- 4
show_cur[s_tri == 1] <- 2
trial_type[s_tri == 1] <- 2
trial_type[m_tri == 1] <- 3


# target direction
# tmod_v <- c(-10,0,10) # set of modification values on target direction
tmod_v <- seq(-15,15,3) # c(-10,0,10) # set of modification values on target direction
num_tmod <- length(tmod_v) # number of modifying direction
# t_deg_mod <- as.vector(replicate(num_tri%/%num_tmod, {x <- tmod_v[sample(num_tmod)]})) # randomize within each "chunk" so that you won't see a value repeated in chunk.
t_deg_mod_pre <- rep(tmod_v,floor(num_tri/num_tmod)) # modify target in M trials only
t_deg_mod <- t_deg_mod_pre[sample(length(t_deg_mod_pre))]

# Add some 0 (no mod) just in case the total number of trials cannot be divided by the number of tmod.
if (num_tri%%num_tmod != 0){
  t_deg_mod <- c(t_deg_mod, sample(tmod_v,num_tri%%num_tmod))
  warning("Total number of trial cannot be divided by the number of target directions. The number of trials is not the same across target directions")
} 

t_deg_raw <- rep(t_deg_ref, num_tri)
# t_deg_raw[m_tri == 1] <- t_deg_ref + t_deg_mod
t_deg_raw <- t_deg_ref + t_deg_mod
t_deg <- t_deg_raw # now apply modification values


### These parameters should be the same across the task, so no need to edit in each script
field <-  rep(0,num_tri)  # No FF in this task
apply_field <-  rep(0,num_tri)
t_radius <- rep(t_radius_ref, num_tri)
wait_time <-  (wait_min + ceiling(runif(num_tri,0,addwait_max)))/1000 # Wait time
bval <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_k11 <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_b11 <- rep(0,num_tri)  # no FF, so 0 bvalue
gain <- rep(0,num_tri)  # no FF, so 0 bvalue
task_break <- rep(0,num_tri) # temporarily

# combine
seq.tgt <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
                 bval, channel_k11, channel_b11, gain, rot_degree,
                 show_arc, show_cur, show_score, train_type, min_score,
                 max_score, difficulty, trial_type, blk_phase,task_break)

for (blk_tag in blk_tags){
  write.table(seq.tgt,sprintf("script/target/output/part/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
}

plot(rot_degree, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






