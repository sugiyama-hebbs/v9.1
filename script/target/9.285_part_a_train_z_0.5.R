## Generate a sequence file (.tgt) for v8.1
#
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)

rm(list = ls()) # clear current workspace, just in case
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
# format: sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id)
version_id = "9.285" # version id
blk_tags <- 0 # block tag
cond <- "train_z_0.5" # condition. Also the main part of filename
pre_tag <- ""
pos_tag <- ""

## Task-related
source("script/target/subscript/set_taskwide_param.R") # set task-wide parameters

# rot_size <- 7 # visual rotation size (degree)

s_tri <- rep(c(rep(1,spc_te),rep(0,mpc_te)),cpb_te_9.28) # flag s trial
m_tri <- rep(c(rep(0,spc_te),rep(1,mpc_te)),cpb_te_9.28) # flag m trial

rot_pattern <- rep(c(2,-2,-6,2,4,-2,6,6,4,-4,-4,-6),
                   cpb_te_9.28/12) # z ~ 0.1

difficulty_pattern <- abs(1/6*1/2*rep(c(2,-2,-6,2,4,-2,6,6,4,-4,-4,-6),
                          cpb_te_9.28/12)) # z ~ 0.1

num_tri <- (spc_te+mpc_te)*cpb_te_9.28

blk_phase <- rep(4, num_tri)
min_score <- rep(-20,num_tri)  
max_score <- rep(0,num_tri) 
difficulty <- rep(1,num_tri)

train_type_lrn <- rep(1,num_tri) 
train_type_nlrn <- rep(2,num_tri) 

# initialize
show_arc <- rep(0,num_tri)
show_cur <- rep(0,num_tri)  
trial_type <- rep(0,num_tri) 
rot_degree <- rep(0,num_tri)
show_score <- rep(0,num_tri)

# assign appropriate values to each type of trial
rot_degree[s_tri == 1] <- rot_pattern # rot_size*rot_pattern
show_arc[s_tri == 1] <- 4
show_arc[m_tri == 1] <- 5
show_cur[s_tri == 1] <- 2
trial_type[s_tri == 1] <- 2
trial_type[m_tri == 1] <- 3
show_score[m_tri == 1] <- 1
difficulty[m_tri == 1] <- difficulty_pattern
# show_score[m_tri == 1] <- 0



tmod_v <- seq(-15,15,3) # set of modification values on target direction
num_tmod <- length(tmod_v) # number of modifying direction

# Randomize within each "chunk" so that there won't be a chunk of the same rotation by chance after randomization 
t_deg_mod = rep(0,num_tri) # Initialize
num_rep =  num_tri/length(tmod_v) # number of trials per one mod value

idx = 1
for (cyc in 1:num_rep){
  t_deg_mod[idx:(idx+num_tmod-1)] = tmod_v[sample(1:num_tmod)]
  idx = idx+num_tmod
}

# Add some 0 (no mod) just in case the total number of trials cannot be divided by the number of tmod.
if (num_tri%%num_tmod != 0){
  remaining_tri <- idx:num_tri
  t_deg_mod[remaining_tri] <- sample(tmod_v, length(remaining_tri))
  warning("Total number of trial cannot be divided by the number of target directions. The number of trials is not the same across target directions")
} 

t_deg_raw <- rep(t_deg_ref, num_tri)
t_deg <-  rep(t_deg_ref, num_tri) + t_deg_mod

### These parameters should be the same across the task, so no need to edit in each script
field <-  rep(0,num_tri)  # No FF in this task
apply_field <-  rep(0,num_tri)
t_radius <- rep(t_radius_ref, num_tri)
wait_time <-  (wait_min + ceiling(runif(num_tri,0,addwait_max_mod)))/1000 # Wait time

wait_time[s_tri == 1] <- wait_time[s_tri == 1]
wait_time[m_tri == 1] <- wait_time[m_tri == 1]

bval <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_k11 <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_b11 <- rep(0,num_tri)  # no FF, so 0 bvalue
gain <- rep(0,num_tri)  # no FF, so 0 bvalue
task_break <- rep(0,num_tri) # temporarily

# combine

seq.tgt_lrn <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
                 bval, channel_k11, channel_b11, gain, rot_degree,
                 show_arc, show_cur, show_score, train_type_lrn, min_score,
                 max_score, difficulty, trial_type, blk_phase, task_break)

seq.tgt_nlrn <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
                     bval, channel_k11, channel_b11, gain, rot_degree,
                     show_arc, show_cur, show_score, train_type_nlrn, min_score,
                     max_score, difficulty, trial_type, blk_phase, task_break)

seq.tgt_base <- cbind(field, apply_field, t_radius, t_deg, wait_time,
                      bval, channel_k11, channel_b11, gain, rot_degree,
                      show_arc, show_cur, rep(0,num_tri), rep(0,num_tri), rep(0,num_tri),
                      rep(0,num_tri), difficulty, trial_type, blk_phase, task_break)


show_arc_strat <- show_arc
show_arc_strat[m_tri == 1] <- 7

seq.tgt_strat <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
                     bval, channel_k11, channel_b11, gain, rot_degree,
                     show_arc_strat, show_cur, show_score, train_type_lrn, min_score,
                     max_score, difficulty, trial_type, blk_phase, task_break)



for (blk_tag in blk_tags){
  write.table(seq.tgt_lrn,sprintf("script/target/output/part/%d%s_%s%s_lrn_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_nlrn,sprintf("script/target/output/part/%d%s_%s%s_nlrn_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_base,sprintf("script/target/output/part/%d%s_%s%s_baseline_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_strat,sprintf("script/target/output/part/%d%s_%s%s_strat_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
}

plot(rot_degree, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






