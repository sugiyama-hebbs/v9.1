## Generate a sequence file (.tgt) 
## This uses output tgt files for other block(s), so run this last.
#
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)

rm(list = ls()) # clear current workspace, just in case
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
version_id = "9.175" # version id
pre_tag <- ""
pos_tag <- ""

## Task-related
# source("script/target/subscript/set_taskwide_param.R") # set task-wide parameters


# seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")

num_train_tri <- dim(seq_lrn)[1]
# num_cycle_to_extract <- 3
# tpc_9.12 <- 7 # trials per cycle

# some hard coding. Be careful about the number of trials to be included/removed
seq_lrn_last <- seq_lrn[(num_train_tri-50+1):num_train_tri, ]

seq_lrn_last[(seq_lrn_last[,13] ==1),13] <- 2
# seq_probe_no_post_wo <- seq_probe[1:25, ]

seq.fam3 <- rbind(seq_lrn_last)

idx_rotation <- 10
seq.fam3[,idx_rotation] <- 0 # remove rotation


write.table(seq.fam3,sprintf("script/target/output/%s/4_fam3_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")






