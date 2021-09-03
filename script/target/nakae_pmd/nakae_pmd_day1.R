## Generate a sequence file (.tgt) 
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)

rm(list = ls()) # clear current workspace, just in case
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
# format: sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id)
version_id = "nakae_pmd" # version id
blk_tags <- 0 # block tag
cond <- "day1" # condition. Also the main part of filename
pre_tag <- ""
pos_tag <- ""

## Task-related
source("script/target/subscript/set_taskwide_param.R") # set task-wide parameters

rot_size <- 5 # visual rotation size (degree)

# s_tri_null_length <- c(4,5,5,4,6,6,4,6,4,6,5,5) # its mean should be an integer

s_tri_length <- rep(1,10) # its mean should be an integer
m_tri_length <- rep(1,10) # its mean should be an integer
null_tri_length <- rep(5,10) # its mean should be an integer

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
  s_tri[seq((k+null_tri_length[i]),((k+null_tri_length[i]+s_tri_length[i]+m_tri_length[i]-1)),2)] <- 1
  rot_degree[seq((k+null_tri_length[i]),((k+null_tri_length[i]+s_tri_length[i]+m_tri_length[i]-1)),2)]  <- rot_pattern[i]*rot_size
  m_tri[seq((k+null_tri_length[i]+1),((k+null_tri_length[i]+s_tri_length[i]+m_tri_length[i]-1)),2)]  <- 1
  k <- k+null_tri_length[i]+s_tri_length[i]+ m_tri_length[i]
}

blk_phase <- rep(4, num_tri)
min_score <- rep(-20,num_tri)  
max_score <- rep(0,num_tri) 
difficulty <- rep(0.5,num_tri)
# difficulty <- rep(0.7,num_tri)

train_type_lrn <- rep(41,num_tri) 
train_type_nlrn <- rep(42,num_tri) 
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
show_cur[m_tri == 1] <- 0
trial_type[null_tri == 1] <- 2
trial_type[s_tri == 1] <- 9
trial_type[m_tri == 1] <- 3
show_score[m_tri == 1] <- 1
# show_score[m_tri == 1] <- 0

tmod_v <- seq(-12,12,6) # set of modification values on target direction
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
tms <-  rep(0,num_tri)
t_radius <- rep(t_radius_ref, num_tri)
wait_time <-  (wait_min_mod2 + ceiling(runif(num_tri,0,addwait_max_mod3)))/1000 # Wait time

wait_time[s_tri == 1] <- wait_time[s_tri == 1]
wait_time[m_tri == 1] <- wait_time[m_tri == 1]

tms[s_tri == 1] <- 1

bval <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_k11 <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_b11 <- rep(0,num_tri)  # no FF, so 0 bvalue
gain <- rep(0,num_tri)  # no FF, so 0 bvalue
task_break <- rep(0,num_tri) # temporarily
task_break[1] <- 1
# combine

# difficulty_lrn <- difficulty
# difficulty_nlrn <- difficulty
# 
# seq.tgt_lrn <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
#                  bval, channel_k11, channel_b11, gain, rot_degree,
#                  show_arc, show_cur, show_score, train_type_lrn, min_score,
#                  max_score, difficulty_lrn, trial_type, blk_phase, task_break, tms)
# 
# seq.tgt_nlrn <- cbind(field, apply_field, t_radius, t_deg, wait_time, 
#                      bval, channel_k11, channel_b11, gain, rot_degree,
#                      show_arc, show_cur, show_score, train_type_nlrn, min_score,
#                      max_score, difficulty_nlrn, trial_type, blk_phase, task_break, tms)

num_sessions <- 10
tms_order_raw <- as.numeric(t(do.call("rbind",lapply(rep(10,num_sessions),sample))))
tms_order <- rep(tms_order_raw, each = tpc)


seq.tgt_base_raw <- cbind(field, apply_field, t_radius, t_deg, wait_time,
                      bval, channel_k11, channel_b11, gain, rot_degree,
                      show_arc, show_cur, rep(0,num_tri), train_type_base, rep(0,num_tri),
                      rep(0,num_tri), difficulty, trial_type, blk_phase, task_break, tms, rep(0,num_tri))




seq.tgt_base <- do.call("rbind", replicate(num_sessions, seq.tgt_base_raw, simplify = FALSE))

seq.tgt_base[1,20] <- 0 # no break in the first trial, of course
seq.tgt_base[, 22] <- tms_order


for (tms_loc in 1:10){
  seq.tgt_base[(tms_order == tms_loc & (seq.tgt_base[,"tms"] == 1 | seq.tgt_base[,"trial_type"] == 3)),"t_deg"] <- 90+rep(c(sample(tmod_v),sample(tmod_v)), each = 2)
}


# tmp <- as.data.frame(seq.tgt_base) %>% 
#   mutate(tri = row_number()) %>% 
#   dplyr::filter(rot_degree != 0 | trial_type == 3) %>% 
#   dplyr::rename(tms_order = V22) %>% 
#   dplyr::select(tri, t_deg,rot_degree,trial_type,tms, tms_order) %>% 
#   arrange(tms_order,t_deg)


# dir.create(file.path("script/target/output/part",version_id), showWarnings = F)
dir.create(file.path("script/target/output/",version_id), showWarnings = F)

  write.table(seq.tgt_base,sprintf("script/target/output/%s/%d%s_%s%s_baseline_%s.txt",version_id,blk_tags[1],pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")

# for (blk_tag in blk_tags){
#   # write.table(seq.tgt_lrn,sprintf("script/target/output/part/%s/%d%s_%s%s_lrn_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
#   #             row.names = F, col.names = F, sep = " ")
#   # write.table(seq.tgt_nlrn,sprintf("script/target/output/part/%s/%d%s_%s%s_nlrn_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
#   #             row.names = F, col.names = F, sep = " ")
#   write.table(seq.tgt_base,sprintf("script/target/output/part/%s/%d%s_%s%s_baseline_%s.txt",version_id,blk_tag,pre_tag,cond,pos_tag,version_id),
#               row.names = F, col.names = F, sep = " ")
# 
# }

plot(rot_degree, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






