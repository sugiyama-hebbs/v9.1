## Generate a sequence file (.tgt) for v8.1
#
# Author: Taisei Sugiyama

# file.edit("script/target/readme.txt") # if you'd like to check the format (which columns represent what. Also, consult task.py)

rm(list = ls()) # clear current workspace, just in case
set.seed(2) # Set a fix seed so that a sequence can be replicated

#### Set key values & parameters ####
## Filename
# format: sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id)
version_id = "8.1" # version id
blk_tags <- c(24,32) # block tag
cond <- "baseline" # condition. Also the main part of filename
pre_tag <- ""
pos_tag <- ""

## Read files
train_raw <- read.csv("script/target/output/part/0_train_8.1.txt", header = F, sep = " ")
probe <- read.csv("script/target/output/part/0_probe_8.1.txt", header = F, sep = " ")
visuorot <- read.csv("script/target/output/part/0_visuorot_8.1.txt", header = F, sep = " ")
rwd_based <- read.csv("script/target/output/part/0_rwd_based_8.1.txt", header = F, sep = " ")
washout <- read.csv("script/target/output/part/0_washout_8.1.txt", header = F, sep = " ")

# combine
train_raw[,14] <- 0  # training type
train_raw[,15] <- 0  # min score
train_raw[,16] <- 0  # max score

num_tri_train <- dim(train_raw)[1] # number of trials in Train
num_tri_per_part <- num_tri_train/3 # divide into 3 parts. number of trials in each part

train_1 <- train_raw[1:num_tri_per_part,]
train_2 <- train_raw[(num_tri_per_part+1):(num_tri_per_part*2),]
train_3 <- train_raw[(num_tri_per_part*2+1):(num_tri_per_part*3),]

seq.tgt <- rbind(washout,train_1,washout,rwd_based,train_2,washout,probe,train_3,washout,visuorot)

for (blk_tag in blk_tags){
  write.table(seq.tgt,sprintf("script/target/output/%d%s_%s%s_%s.txt",blk_tag,pre_tag,cond,pos_tag,version_id),
              row.names = F, col.names = F, sep = " ")
}

plot(seq.tgt[,10], type ="l", main = cond, xlab = "Trial", ylab = "Rotation [deg]")






