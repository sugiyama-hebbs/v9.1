## Generate a sequence file (.tgt) 
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)

rm(list = ls()) # clear current workspace, just in case
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
# format: sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id)
version_id = "9.1742" # version id
blk_tags <- 0 # block tag
cond <- "train" # condition. Also the main part of filename
pre_tag <- ""
pos_tag <- ""

## Task-related
source("script/target/subscript/set_taskwide_param.R") # set task-wide parameters

rot_size <- 5 # visual rotation size (degree)

# s_tri_null_length <- c(4,5,5,4,6,6,4,6,4,6,5,5) # its mean should be an integer

s_tri_length <- rep(5,6) # its mean should be an integer
m_tri_length <- rep(3,6) # its mean should be an integer
null_tri_length <- rep(10,6) # its mean should be an integer

cps <- length(s_tri_length) # number of cycles per 1 set

rot_pattern <- rep(c(1),cps)

stopifnot(length(rot_pattern) == cps)

tpc <- mean(s_tri_length) + mean(m_tri_length)+ mean(null_tri_length)

num_tri <- tpc * cps

s_tri <- rep(0,num_tri)
m_tri <- rep(0,num_tri)
null_tri <- rep(0,num_tri)
null_tri_count_error <- rep(0,num_tri)
rot_degree <- rep(0,num_tri)

k <- 1
for (i in 1:cps){
  null_tri[k:(k+null_tri_length[i]-1)] <- 1
  null_tri_count_error[(k+null_tri_length[i]/2):(k+null_tri_length[i]-1)] <- 1
  s_tri[(k+null_tri_length[i]):(k+null_tri_length[i]+s_tri_length[i]-1)] <- 1
  rot_degree[(k+null_tri_length[i]):(k+null_tri_length[i]+s_tri_length[i]-1)]  <- rot_pattern[i]*rot_size
  m_tri[((k+null_tri_length[i]+s_tri_length[i])):((k+null_tri_length[i]+s_tri_length[i]+m_tri_length[i]-1))]  <- 1
  k <- k+null_tri_length[i]+s_tri_length[i]+ m_tri_length[i]
}

blk_phase <- rep(4, num_tri)
min_score <- rep(-20,num_tri)  
max_score <- rep(0,num_tri) 
# difficulty <- rep(0.5,num_tri)
difficulty <- rep(0.7,num_tri)

train_type_lrn <- rep(31,num_tri) 
train_type_nlrn <- rep(22,num_tri) 
train_type_base <- rep(99,num_tri)

# initialize
show_arc <- rep(6,num_tri)
show_cur <- rep(3,num_tri)  
trial_type <- rep(0,num_tri) 

show_score <- rep(0,num_tri)

# assign appropriate values to each type of trial
# rot_degree[s_tri ==1] <- rot_size*rot_pattern
show_arc[null_tri == 1] <- 7
# show_arc[m_tri == 1] <- 5
show_cur[null_tri == 1] <- 2
trial_type[s_tri == 1 | null_tri == 1] <- 2
trial_type[null_tri_count_error == 1] <- 5
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
wait_time <-  (wait_min_mod2 + ceiling(runif(num_tri,0,addwait_max_mod3)))/1000 # Wait time

wait_time[s_tri == 1] <- wait_time[s_tri == 1]
wait_time[m_tri == 1] <- wait_time[m_tri == 1]

bval <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_k11 <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_b11 <- rep(0,num_tri)  # no FF, so 0 bvalue
gain <- rep(0,num_tri)  # no FF, so 0 bvalue
task_break <- rep(0,num_tri) # temporarily

# combine

difficulty_lrn <- difficulty
difficulty_nlrn <- difficulty

seq.tgt_lrn <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
                 bval, channel_k11, channel_b11, gain, rot_degree,
                 show_arc, show_cur, show_score, train_type_lrn, min_score,
                 max_score, difficulty_lrn, trial_type, blk_phase, task_break)


# seq.tgt_lrn_5deg <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
#                      bval, channel_k11, channel_b11, gain, rot_degree/rot_size*5,
#                      show_arc, show_cur, show_score, train_type_lrn, min_score,
#                      max_score, difficulty_lrn, trial_type, blk_phase, task_break)

seq.tgt_nlrn <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
                     bval, channel_k11, channel_b11, gain, rot_degree,
                     show_arc, show_cur, show_score, train_type_nlrn, min_score,
                     max_score, difficulty_nlrn, trial_type, blk_phase, task_break)

seq.tgt_base <- cbind(field, apply_field, t_radius, t_deg, wait_time,
                      bval, channel_k11, channel_b11, gain, rot_degree,
                      show_arc, show_cur, rep(0,num_tri), train_type_base, rep(0,num_tri),
                      rep(0,num_tri), difficulty, trial_type, blk_phase, task_break)

# show_score_rand <- show_score
# show_score_rand[show_score_rand==1] <- 2
# 
# seq.tgt_rand <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
#                      bval, channel_k11, channel_b11, gain, rot_degree,
#                      show_arc, show_cur, show_score_rand, train_type_lrn, min_score,
#                      max_score, difficulty_lrn, trial_type, blk_phase, task_break)


# show_cur_clamp <- show_cur
# show_cur_clamp[s_tri == 1] <- 3
# 
# seq.tgt_lrn_clamp <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
#                            bval, channel_k11, channel_b11, gain, rot_degree,
#                            show_arc, show_cur_clamp, show_score, train_type_lrn, min_score,
#                            max_score, difficulty_lrn, trial_type, blk_phase, task_break)
# 
# 
# seq.tgt_nlrn_clamp <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
#                            bval, channel_k11, channel_b11, gain, rot_degree,
#                            show_arc, show_cur_clamp, show_score, train_type_nlrn, min_score,
#                            max_score, difficulty_nlrn, trial_type, blk_phase, task_break)
# 
# seq.tgt_base_clamp <- cbind(field, apply_field, t_radius, t_deg, wait_time,
#                       bval, channel_k11, channel_b11, gain, rot_degree,
#                       show_arc, show_cur_clamp, rep(0,num_tri), train_type_base, rep(0,num_tri),
#                       rep(0,num_tri), difficulty, trial_type, blk_phase, task_break)

dir.create(file.path("script/target/output/part",version_id), showWarnings = F)
for (blk_tag in blk_tags){
  write.table(seq.tgt_lrn,sprintf("script/target/output/part/%s/%d%s_%s%s_lrn_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  # write.table(seq.tgt_lrn_5deg,sprintf("script/target/output/part/%s/%d%s_%s%s_lrn_5deg_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
  #             row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_nlrn,sprintf("script/target/output/part/%s/%d%s_%s%s_nlrn_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
  write.table(seq.tgt_base,sprintf("script/target/output/part/%s/%d%s_%s%s_baseline_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
}

plot(rot_degree, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






