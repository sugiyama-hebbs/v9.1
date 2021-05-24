## Generate a sequence file (.tgt) for v8.1
#
# Author: Taisei Sugiyama

## Format
# 1 = field: force-field type (0=Null, 1=Viscous FF, 3=Channel) * 2 is currently not used
# 2 = apply_field: (not really used. maybe just remove)
# 3 = target radius: distance between the start and the shoot boundary (target)
# 4 = target degree: target direction
# 5 = b_value: viscous force value (constant)
# 6 = channel_k11: channel force (not really used. maybe just remove)
# 7 = channel_B11: channel force (not really used. maybe just remove)
# 8 = gain for spring force during movement. Usually set to 0  (except "pseudo" isometric force task, maybe)
# 9 = rot_degree: cursor rotation in degree
# 10 = show_arc: whether to present an arc instead of a point target
# 11 = show_cur: whether to show cursor 
# 12 = show_score: whether to show score 
# 13 = training_type: type of meta-learning training. 1: Lrn, 2: NLrn, 3: Reward-based (not a meta-learning training, but rather a control condition)
# 14 = minimum_score: min score that can be earned in a trial
# 15 = maximum_score: max score that can be earned in a trial
# 16 = difficulty: constant defining how much point is reduced per 10% of learning wrt last experienced rotation (e.g., if this is 3 and you're 20% off from the ideal learning amount (100% in Lrn and 0% in NLrn), you get 3 x 20%/10% = 6 points less)

rm(list = ls()) # clear current workspace just in case

#### Set key values ####

## General
fname = "8.1" # sequence file name

t_deg_ref <- 90 # reference target direction
t_radius_ref <- 0.1 # reference target radius (m)
rot_size <- 7 # visual rotation size (degree)
wait_min <- 600 # minimum wait time (ms)
addwait_max <- 600 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  

blk_tag <- 0
cond <- "pre_train"
sub_tag <- ""
sub_tag2 <- ""


ph0 = 60 # trials in phase 0 (Pre-Train)
ph1 = 0 # trials in phase 1 (Pre-Fam1)
ph2 = 0 # trials in phase 2 (Pre-Probe)
ph3 = 0 # trials in phase 3 (Pre-Fam2)
ph4 = 0 # trials in phase 4 (Train)
ph5 = 0 # trials in phase 5 (Post-Train Washout)
ph6 = 0 # trials in phase 6 (Post-Probe)
ph7 = 0 # trials in phase 7(new probe)

num_tri <- ph0 + ph1 + ph2 + ph3 + ph4 + ph5 + ph6 + ph7 # number of total trials

set.seed(2) # Set a fix seed so that a sequence can be replicated

field <-  rep(0,num_tri)  # No FF in this task
apply_field <-  rep(0,num_tri)
t_radius <- rep(t_radius_ref, num_tri)
t_deg <- rep(t_deg_ref, num_tri)
wait_time <-  (wait_min + ceiling(runif(num_tri,0,addwait_max)))/1000 # Wait time
bval <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_k11 <- rep(0,num_tri)  # no FF, so 0 bvalue
channel_b11 <- rep(0,num_tri)  # no FF, so 0 bvalue
gain <- rep(0,num_tri)  # no FF, so 0 bvalue
rot_degree <- c(rep(0,num_tri/3),rep(rot_size,num_tri/3),rep(0,num_tri/3)) # apply rotation in the mid way
show_arc <- rep(0,num_tri)  # no arc
show_cur <- rep(1,num_tri)  # always cursor
show_score <- rep(0,num_tri)  # no score
train_type <- rep(0,num_tri)  
min_score <- rep(0,num_tri)  
max_score <- rep(0,num_tri) 
difficulty <- rep(1,num_tri)

phase <- c(rep(0,ph0),rep(1,ph1),rep(2,ph2),rep(3,ph3),rep(4,ph4),rep(5,ph5),rep(6,ph6),rep(7,ph7))

seq.tgt <-   cbind(field, apply_field, t_radius, t_deg, wait_time, 
                   bval, channel_k11, channel_b11, gain, rot_degree,
                   show_arc, show_cur, show_score, train_type, min_score,
                   max_score, difficulty)

write.table(seq.tgt,sprintf("script/target/%d%s_%s_%s%s.txt",blk_tag,sub_tag,fname,cond,sub_tag2),
            row.names = F, col.names = F, sep = " ")

plot(rot_degree, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






