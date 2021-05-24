
tpc <- spc + mpc

## Trial numbers. Note that this appears more complicated than necessary, but this is for consistency with the original version (v1.11)
if (cond == "fam1"){
  ph1 = 35 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 0 # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)
  ph7 = 0 # trials in phase 7(new probe)
  
} else if (cond == "fam2a"){
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 10 # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)
  ph7 = 0 # trials in phase 7(new probe)
} else if (cond == "fam2b"){
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 10 # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)
  ph7 = 0 # trials in phase 7(new probe)
} else if (cond == "fam2c"){
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 20 # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)
  ph7 = 0 # trials in phase 7(new probe)
} else if (cond %in% c("rwd_based","rwd_based_pr","rwd_based_w","rwd_based_pr_w")){
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 20 # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)
  ph7 = 0 # trials in phase 7(new probe)
} else if (cond == "visuo_rot") {
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 0 # trials in phase 4 (Train)
  ph5 = 5 # trials in phase 5 (Post-Train Washout)
  ph6 = 20 # trials in phase 6 (Post-Probe)  
  ph7 = 0 # trials in phase 7(new probe)
} else if (cond %in% c("ga","na","gw","nw","norwd")) {
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 5 # trials in phase 3 (Pre-Fam2)
  ph4 = tpc*num_c # trials in phase 4 (Train)
  ph5 = 0 # trials in phase 5 (Post-Train Washout)
  ph6 = 0 # trials in phase 6 (Post-Probe)
  ph7 = 0 # trials in phase 7(new probe)
} else if (cond == "pre_train"){
  ph1 = 0 # trials in phase 1 (Pre-Fam1)
  ph2 = 0 # trials in phase 2 (Pre-Probe)
  ph3 = 0 # trials in phase 3 (Pre-Fam2)
  ph4 = 0 # trials in phase 4 (Train)
  ph5 = 20 # trials in phase 5 (Post-Train Washout)
  ph6 = 40 # trials in phase 6 (Post-Probe)  
  ph7 = 0 # trials in phase 7(new probe)
} else {
  stop("Unexpected blk_tag number") # some wrong number was input
}

num_tri <- ph1 + ph2 + ph3 + ph4 + ph5 + ph6 + ph7 # number of total trials


if (cond %in% c("rwd_based","rwd_based_pr","ga","na")){
  max_score <- 0 # max score per M trial
  min_score <- -20 # min score per M trial
} else if (cond %in% c("rwd_based_w","rwd_based_pr_w","gw","nw")){
  max_score <- 20 # max score per M trial
  min_score <- 0 # min score per M trial
  
}




if (cond %in% c("rwd_based","rwd_based_pr","rwd_based_w","rwd_based_pr_w")){
  tri_type <- rep(3,num_tri) # Rwd-based (same as learn)
  max_s = rep(max_score,num_tri)
  min_s = rep(min_score,num_tri)
  base_pen_unit = 1 # basepenalty unit (How much score point change per 1 error unit)
  
} else if (cond %in% c("ga","na","gw","nw")) {
  if (cond %in% c("ga","gw")){
    tri_type <- rep(1,num_tri) 
  } else if (cond %in% c("na","nw")){
    tri_type <- rep(2,num_tri) 
  }
  
  max_s = rep(max_score,num_tri)
  min_s = rep(min_score,num_tri)
  base_pen_unit = 1 # basepenalty unit (How much score point change per 1 error unit)
  
} else {
  tri_type <- rep(0,num_tri) # NoMF
  max_s = rep(0,num_tri)
  min_s = rep(0,num_tri)
  base_pen_unit = 0 # basepenalty unit (How much score point change per 1 error unit)
}
