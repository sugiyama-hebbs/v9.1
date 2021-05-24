## Combine tgt sequence files. 
# This is made as some "large" blocks is made up from smaller blocks
# Author: Taisei Sugiyama




rm(list = ls()) # clear current workspace just in case
#
library(dplyr)

#### Set key values ####
fname = "7.17" # sequence file name
# conds <- c("ga","na","ga_last_half","na_last_half","ga_last_qt","na_last_qt")
conds <- c("norwd","norwd_w","ga","na","ga_last_half","na_last_half","gw","nw","gw_last_half","nw_last_half")
blk_tags <- c(6,6,7,7,9,9,7,7,9,9)



## Preparation
num_out <- length(conds) # number of tgt files to be created

tgt_train_ga <- read.csv("script/target/7a_7.17_ga_raw.tgt", header = F, sep = " ")
tgt_train_na <- read.csv("script/target/7b_7.17_na_raw.tgt", header = F, sep = " ")
tgt_train_gw <- read.csv("script/target/7c_7.17_gw_raw.tgt", header = F, sep = " ")
tgt_train_nw <- read.csv("script/target/7d_7.17_nw_raw.tgt", header = F, sep = " ")
tgt_train_norwd <- read.csv("script/target/6_7.17_norwd_raw.tgt", header = F, sep = " ")
tgt_probe <- read.csv("script/target/11_7.17_probe_raw.tgt", header = F, sep = " ")
tgt_visuo <- read.csv("script/target/10_7.17_visuo_rot.tgt", header = F, sep = " ")
tgt_rwd_based <- read.csv("script/target/11_7.17_rwd_based.tgt", header = F, sep = " ")
tgt_rwd_based_w <- read.csv("script/target/11_7.17_rwd_based_w.tgt", header = F, sep = " ")

num_train_tri <- length(tgt_train_ga %>% 
                          dplyr::filter(V11 == 4) %>% 
                          .$V1)

num_wo_tri <- length(tgt_train_ga %>% 
                       dplyr::filter(V11 == 3) %>% 
                       .$V1)


for (i in 1:num_out){
  
  
  if (conds[i] == "ga"){
    seq.tgt <- rbind(tgt_train_ga,tgt_probe)
  } else if (conds[i] == "na"){
    seq.tgt <- rbind(tgt_train_na,tgt_probe)
  } else if (conds[i] == "gw"){
    seq.tgt <- rbind(tgt_train_gw,tgt_probe)
  } else if (conds[i] == "nw"){
    seq.tgt <- rbind(tgt_train_nw,tgt_probe)
  } else if (conds[i] == "ga_last_half"){
    sep_tri <- num_wo_tri + num_train_tri/2 # where block is separated
    seq.tgt <- rbind(tgt_train_ga[1:sep_tri,], tgt_probe, tgt_rwd_based,
                  tgt_train_ga[(sep_tri+1):(num_wo_tri + num_train_tri),],tgt_visuo)
  } else if (conds[i] == "na_last_half"){
    sep_tri <- num_wo_tri + num_train_tri/2 # where block is separated
    seq.tgt <- rbind(tgt_train_na[1:sep_tri,], tgt_probe, tgt_rwd_based,
                     tgt_train_na[(sep_tri+1):(num_wo_tri + num_train_tri),],tgt_visuo)
  } else if (conds[i] == "gw_last_half"){
    sep_tri <- num_wo_tri + num_train_tri/2 # where block is separated
    seq.tgt <- rbind(tgt_train_gw[1:sep_tri,], tgt_probe, tgt_rwd_based_w,
                  tgt_train_gw[(sep_tri+1):(num_wo_tri + num_train_tri),],tgt_visuo)
  } else if (conds[i] == "nw_last_half"){
    sep_tri <- num_wo_tri + num_train_tri/2 # where block is separated
    seq.tgt <- rbind(tgt_train_nw[1:sep_tri,], tgt_probe, tgt_rwd_based_w,
                     tgt_train_nw[(sep_tri+1):(num_wo_tri + num_train_tri),],tgt_visuo)
  } else if (conds[i] == "norwd"){
    seq.tgt <- rbind(tgt_train_norwd,tgt_probe, tgt_rwd_based, tgt_visuo)
  }else if (conds[i] == "norwd_w"){
    seq.tgt <- rbind(tgt_train_norwd,tgt_probe, tgt_rwd_based_w, tgt_visuo)
  }
    
  # } else if (conds[i] == "ga_last_qt"){
  #   sep_tri <- num_wo_tri + num_train_tri*3/4 # where block is separated
  #   seq.tgt <- rbind(tgt_train_ga[1:sep_tri,], tgt_probe, tgt_rwd_based,
  #                    tgt_train_ga[(sep_tri+1):(num_wo_tri + num_train_tri),],tgt_visuo)
  # } else if (conds[i] == "na_last_qt"){
  #   sep_tri <- num_wo_tri + num_train_tri*3/4 # where block is separated
  #   seq.tgt <- rbind(tgt_train_na[1:sep_tri,], tgt_probe, tgt_rwd_based,
  #                    tgt_train_na[(sep_tri+1):(num_wo_tri + num_train_tri),],tgt_visuo)
  # }
  cond <- conds[i]
  blk_tag <-blk_tags[i]
  
  write.table(seq.tgt,sprintf("script/target/%d_%s_%s.tgt",blk_tag,fname,cond),
              row.names = F, col.names = F, sep = " ")
  
  # plot(rot, type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")
  
}

