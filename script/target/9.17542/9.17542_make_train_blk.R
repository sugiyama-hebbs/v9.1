# make a train block from parts

version_id <- "9.17542"

# seq_genuine <- read.csv(sprintf("script/target/output/part/%s/0_genuine_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_original_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_original_lrn_%s.txt",version_id,version_id), header = F, sep=" ")


seq_wo <- seq_probe[1:35,] # get only washout phase

seq.tgt_lrn <- rbind(seq_lrn,seq_wo)
seq.tgt_original_lrn <- rbind(seq_original_lrn,seq_wo)

# idx_rot <- 10
# seq.tgt_lrn_single_rot <- seq.tgt_lrn
# seq.tgt_lrn_single_rot[,idx_rot] <- abs(seq.tgt_lrn_single_rot[,idx_rot])

dir.create(file.path("script/target/output",version_id), showWarnings = F)
# write.table(seq.tgt_lrn,sprintf("script/target/output/%s/5a_train_lrn_%s.txt",version_id,version_id),
#             row.names = F, col.names = F, sep = " ")
# 
# write.table(seq.tgt_lrn_single_rot,sprintf("script/target/output/%s/6a_train_lrn_single_rot_%s.txt",version_id,version_id),
#             row.names = F, col.names = F, sep = " ")

# write.table(seq.tgt_lrn_clamp,sprintf("script/target/output/%s/5a_train_lrn_clamp_%s.txt",version_id,version_id),
#             row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_lrn,sprintf("script/target/output/%s/7a_train_lrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_lrn,sprintf("script/target/output/%s/8a_train_original_lrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")
