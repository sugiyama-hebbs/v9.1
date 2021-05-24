## Generate a sequence file (.tgt) for v7.13
# additional probe blocks for testing
# Author: Taisei Sugiyama


## Format
# 1=tdir: target direction.
# 2=wait_time (msec): Waiting time.
# 3=bval: strength of force field. Set 0 if no FF.
# 4=field: field type. 1-FF, 3-Channel
# 5=rot: size of visual rotation (deg).
# 6=max_s: max score
# 7=base_pen: base penalty size (how much point change per error unit)
# 8=shcur: showing cursor 
# 9=mf: motivational feedback (score)
# 10=tsize: visible target size (constant for now)
# 11=phase: phase number in a block (e.g., 4 is Train phase)
# 12=tri_type: relationship type between score and aftereffect (i.e., task demand)
# 13=min_s: minimum score

rm(list = ls()) # clear current workspace just in case

#### Set key values ####

## General
fname = "7.17" # sequence file name

tdir_ref <- 90 # reference Target direction
tsize_ref <- 2 # target size
wait_min <- 600 # minimum wait time (ms)
addwait_max <- 600 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  

spc <- 1 # S trial per cycle
mpc <- 4 # M trial per cycle 
num_c <- 28 # number of cycle 

max_score <- 0 # max score per M trial
min_score <- -20 # min score per M trial

conds <- c("probe")
blk_tags <- c(11)

num_out <- length(conds) # number of tgt files to be created

for (i in 1:num_out){
  
  set.seed(2) # Set a fix seed so that a sequence can be replicated
  
  cond <- conds[i]
  blk_tag <-blk_tags[i]
  
  rot_size <- 7

  s_ph7 <-c(rep(c(0,1),20),0)
  m_ph7 <- (s_ph7-1)*(-1)
  rot_ph7 <- rot_size*s_ph7
  rot_ph7[1:20] <- 0 # no rotation initially 
  rot <-rot_ph7
  
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 0 # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)  
  ph7 = length(s_ph7) # trials in phase 7(new probe)
  
  num_tri <- ph1 + ph2 + ph3 + ph4 + ph5 + ph6 + ph7 # number of total trials
  
  
  ### MF, Cursor visibility
  base_pen_unit <- 0 # basepenalty unit (How much score point change per 1 error unit)
  shcur <- s_ph7 # cursor is visible except M trials
  mf <- rep(0,num_tri) # motivational feedback available only in M trials train phase
  tsize = tsize_ref*m_ph7 # hide target in S trial  }
  field = rep(1,num_tri)  # field is always 1 (FF) for this version
  bval = rep(0,num_tri)  # no FF, so 0 bvalue
  wait_time = wait_min + ceiling(runif(num_tri,0,addwait_max)) # Wait time (originally called iti)
  base_pen = rep(base_pen_unit,num_tri)
  phase = c(rep(1,ph1),rep(2,ph2),rep(3,ph3),rep(4,ph4),rep(5,ph5),rep(6,ph6),rep(7,ph7))
  tri_type <- rep(0,num_tri) # NoMF
  max_s = rep(0,num_tri)
  min_s = rep(0,num_tri)
  tdir <- rep(tdir_ref,num_tri) 

  ### Combine everything and save ### 
  seq.tgt <-  cbind(tdir,wait_time,bval,field,rot,
                    max_s,base_pen,shcur,mf,tsize,
                    phase,tri_type,min_s)
  
    sub_tag <- ""
  
  write.table(seq.tgt,sprintf("script/target/%d%s_%s_%s_raw.tgt",blk_tag,sub_tag,fname,cond),
              row.names = F, col.names = F, sep = " ")
  
  plot(rot, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")

}





