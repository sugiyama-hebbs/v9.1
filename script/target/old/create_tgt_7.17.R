## Generate a sequence file (.tgt) for v7.17
#
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
rot_size <- 7 # visual rotation size (degree)
tsize_ref <- 2 # target size
wait_min <- 600 # minimum wait time (ms)
addwait_max <- 600 # additional max wait time. An additional time for each trial is randomly selected from a uniform distribution from 0 to this number.  

spc <- 1 # S trial per cycle
mpc <- 4 # M trial per cycle 
num_c <- 28 # number of cycle 




# Conditions
# ga : go to avoid (a.k.a. Lrn-Pun)
# na : nogo to avoid (a.k.a.  NLrn-Pun)

conds <- c("fam1","fam2b","fam2a","fam2c","rwd_based_pr","rwd_based_pr_w","norwd","ga","na","gw","nw","visuo_rot","rwd_based_w","rwd_based")
blk_tags <- c(1,2,3,4,5,5,6,7,7,7,7,10,11,11)

num_out <- length(conds) # number of tgt files to be created

for (i in 1:num_out){
  
  set.seed(2) # Set a fix seed so that a sequence can be replicated
  
  cond <- conds[i]
  blk_tag <-blk_tags[i]
  #### Processing ####
  ## Some preparation & short processing
  source("script/target/subscript/set_blk_specific_param.R") # set block-specific parameters
  source("script/target/subscript/process_miscell_sch.R")
  
  ### Target direction
  if (cond == "fam1"){
    tmod_v <- c(-45,-30,-15,0,15,30,45) # set of modification values on target direction
  } else {
    tmod_v <- 0
  }
  
  num_tmod <- length(tmod_v) # number of modifying direction
  tdir_mod <- as.vector(replicate(num_tri%/%num_tmod, {x <- tmod_v[sample(num_tmod)]})) # randomize within each "chunk" so that you won't see a value repeated in chunk.
  
  # Add some 0 (no mod) just in case the total number of trials cannot be divided by the number of tmod.
  if (num_tri%%num_tmod != 0){
    tdir_mod <- c(tdir_mod, rep(0,num_tri%%num_tmod))
    warning("Total number of trial cannot be divided by the number of target directions. The number of trials is not the same across target directions")
  } 
  # }
  tdir <- rep(tdir_ref,num_tri) +  tdir_mod # now add the mod values to the reference direction
  
  
  ### Shift
  if (cond %in% c("ga","na","norwd","gw","nw")){
    s_tri <- rep(c(rep(1,spc),rep(0,mpc)),num_c) # flag s trial
    m_tri <- rep(c(rep(0,spc),rep(1,mpc)),num_c) # flag m trial
  } else if (cond == "fam2a") {
    s_tri <- rep(1,ph4)
    m_tri <- rep(0,ph4)
  } else if (cond == "fam2b") {
    s_tri <- rep(0,ph4)
    m_tri <- rep(1,ph4)
  } else if (cond == "fam2c") {
    temp_flag <- sample(2:ph4, ((ph4/2)-1))
    s_tri <- rep(0,ph4)
    s_tri[1] <- 1 # always start from s
    s_tri[temp_flag] <-  1
    m_tri <- (s_tri - 1)*(-1) # flag non-s trials
  } else if (cond %in% c("rwd_based","rwd_based_pr","rwd_based_w","rwd_based_pr_w")){
    # s_tri <- c(rep(1,5),rep(0,(ph4-5)))
    s_tri <- rep(0,ph4)
    m_tri <- rep(1,ph4)
  } else {
    s_tri <- numeric()
    m_tri <- numeric()
  }
  
  
  
  ## Rotation pattern in Train. Hard coding to mimic the sequence in the original version
  rot_pattern <- c(-1,1,1,-1,1,1,-1,-1,-1,
                   1,1,-1,1,1,1,-1,1,1,-1,
                   -1,-1,-1,-1,1,1,-1,-1,1
  )
  
  rot_tr <- rep(0,ph4) # initialize
  
  if (cond %in% c("rwd_based","rwd_based_w")){
    rot_tr[(ph4-9):ph4] <- rot_size # add rotation in last 10 trials
  } else if (cond %in% c("ga","na","gw","nw","norwd")){
    rot_tr[s_tri == 1] <- rot_size * rot_pattern # substitute rotations in S trials
  }
  
  ## Rotation pattern in visuomotor-Probe.
  rot_pr1 <- rot_size*rep(1,ph2) # only one direction
  rot_pr2 <- rot_size*c(rep(1,(ph6/2)),rep(0,(ph6/2))) # only one direction
  
  ## Rotation pattern in new probe (generated in a separate file now)
  s_ph7 <- numeric()
  m_ph7 <- numeric()
  rot_ph7 <- numeric()
  
  
  # now combine
  rot <- c(rep(0,ph1),rot_pr1,rep(0,ph3),rot_tr,rep(0,ph5),rot_pr2,rot_ph7)
  
  ### MF, Cursor visibility
  shcur <- c(rep(1,(ph1+ph2+ph3)),s_tri,rep(1,ph5+ph6), s_ph7) # cursor is visible except M trials
  
  if (cond %in% c("ga","na","gw","nw","rwd_based","rwd_based_pr","rwd_based_w","rwd_based_pr_w","norwd")) {
    mf <- c(rep(0,(ph1+ph2+ph3)),m_tri,rep(0,ph5+ph6+ph7)) # motivational feedback available only in M trials
  } else {
    mf <- rep(0,num_tri) # motivational feedback available only in M trials train phase
  }
  
  tsize = tsize_ref*c(rep(1,(ph1+ph2+ph3)),m_tri,rep(1,ph5+ph6),m_ph7) # hide target in S trial  }
  
  ### Combine everything and save ### 
  seq.tgt <-  cbind(tdir,wait_time,bval,field,rot,
                    max_s,base_pen,shcur,mf,tsize,
                    phase,tri_type,min_s)
  
  if (cond == "ga"){
    sub_tag <- "a"
    sub_tag2 <- "_raw"
  } else if (cond == "na"){
    sub_tag <- "b"
    sub_tag2 <- "_raw"
  } else if (cond == "gw"){
    sub_tag <- "c"
    sub_tag2 <- "_raw"
  } else if (cond == "nw"){
    sub_tag <- "d"
    sub_tag2 <- "_raw"
  } else if (cond == "norwd"){
    sub_tag <- ""
    sub_tag2 <- "_raw"
  } else {
    sub_tag <- ""
    sub_tag2 <- ""
  }
  
  write.table(seq.tgt,sprintf("script/target/%d%s_%s_%s%s.tgt",blk_tag,sub_tag,fname,cond,sub_tag2),
              row.names = F, col.names = F, sep = " ")
  
  plot(rot, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")
  
}





