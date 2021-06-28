## Generate a sequence file (.tgt) for v8.1
#
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)

rm(list = ls()) # clear current workspace, just in case
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
# format: sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id)
version_id = "9.2" # version id
blk_tags <- 0 # block tag
cond <- "train_low_z_3.5" # condition. Also the main part of filename
pre_tag <- ""
pos_tag <- ""

## Task-related
source("script/target/subscript/set_taskwide_param.R") # set task-wide parameters

rot_size <- 3.5 # visual rotation size (degree)


# s_tri_null_length <- c(4,5,5,4,6,6,4,6,4,6) # its mean should be an integer
s_tri_null_length <- c(4,5,5,6,6,4) # its mean should be an integer

cps <- length(s_tri_null_length) # number of cycles per 1 set

# rot_pattern <- c(-1,1,-1,1,-1,1,1,-1,-1,1) # z ~ 0.1
rot_pattern <- c(-1,1,-1,-1,1,1) # z ~ 0.1

stopifnot(length(rot_pattern) == cps)

tpc <- mean(s_tri_null_length) + 2 # s_tri_null + rot_s + m

num_tri <- tpc * cps

s_tri_null <- rep(0,num_tri)
s_tri_rot <- rep(0,num_tri)
m_tri <- rep(0,num_tri)

k <- 1
for (i in 1:cps){
  s_tri_null[k:(k+s_tri_null_length[i]-1)] <- 1
  s_tri_rot[k+s_tri_null_length[i]] <- 1
  m_tri[k+s_tri_null_length[i]+1] <- 1
  k <- k+s_tri_null_length[i]+2
}


# 
# ph4 = tpc*cpb_9.2 # cycles per block # trials in phase 4 (Train)
# ph5 = 0 # trials in phase 5 (Post-Train Washout)
# ph6 = 0 # trials in phase 6 (Post-Probe)
# ph7 = 0 # trials in phase 7 (visuomotor)
# ph8 = 0 # trials in phase 8 (reward-based)
# ph9 = 0 # trials in phase 9 (extra)
# 
# blk_phase <- c(rep(0,ph0),rep(1,ph1),rep(2,ph2),rep(3,ph3),rep(4,ph4),rep(5,ph5),rep(6,ph6),rep(7,ph7),rep(8,ph8),rep(9,ph9))
# num_tri <- ph0 + ph1 + ph2 + ph3 + ph4 + ph5 + ph6 + ph7 + ph8 + ph9

blk_phase <- rep(4, num_tri)
min_score <- rep(-20,num_tri)  
max_score <- rep(0,num_tri) 
difficulty <- rep(0.5,num_tri)

train_type_lrn <- rep(1,num_tri) 
train_type_nlrn <- rep(2,num_tri) 

# initialize
show_arc <- rep(0,num_tri)
show_cur <- rep(0,num_tri)  
trial_type <- rep(0,num_tri) 
rot_degree <- rep(0,num_tri)
show_score <- rep(0,num_tri)

# assign appropriate values to each type of trial
rot_degree[s_tri_rot == 1] <- rot_size*rot_pattern
show_arc[s_tri_rot == 1 | s_tri_null == 1] <- 4
show_arc[m_tri == 1] <- 5
show_cur[s_tri_rot == 1 | s_tri_null == 1] <- 2
trial_type[s_tri_rot == 1 | s_tri_null == 1] <- 2
trial_type[m_tri == 1] <- 3
show_score[m_tri == 1] <- 1
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
wait_time <-  (wait_min_mod + ceiling(runif(num_tri,0,addwait_max_mod)))/1000 # Wait time
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

for (blk_tag in blk_tags){
  write.table(seq.tgt_lrn,sprintf("script/target/output/part/%d%s_%s%s_lrn_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_nlrn,sprintf("script/target/output/part/%d%s_%s%s_nlrn_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_base,sprintf("script/target/output/part/%d%s_%s%s_baseline_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
}

plot(rot_degree, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






