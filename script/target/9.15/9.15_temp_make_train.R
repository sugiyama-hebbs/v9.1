# make a train block from parts
# insert break before probe
version_id <- "9.15"

# seq_genuine <- read.csv(sprintf("script/target/output/part/%s/0_genuine_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_nlrn <- read.csv(sprintf("script/target/output/part/%s/0_train_nlrn_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_base <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_rand <- read.csv(sprintf("script/target/output/part/%s/0_train_rand_%s.txt",version_id,version_id), header = F, sep=" ")

seq_lrn_clamp <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_clamp_%s.txt",version_id,version_id), header = F, sep=" ")
seq_base_clamp <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_clamp_%s.txt",version_id,version_id), header = F, sep=" ")

# seq_lrn_clamp_break <- seq_lrn_clamp
# seq_lrn_break[1,20] = 1
# seq_nlrn_break <- seq_nlrn
# seq_nlrn_break[1,20] = 1
# seq_base_break <- seq_base
# seq_base_break[1,20] = 1

seq_probe_break <- seq_probe
seq_probe_break[26,20] <- 1 # hard coding. be careful about the # of pre-washouts and rotation trials

seq_probe_break_before <- seq_probe
seq_probe_break_before[1,20] <- 1 # hard coding. be careful about the # of pre-washouts and rotation trials

seq.tgt_base_before <- rbind(seq_probe,
                             seq_base_clamp,
                             seq_probe_break_before)

seq.tgt_base <- rbind(seq_probe,
                     seq_base_clamp,seq_probe)


# write.table(seq.tgt_lrn,sprintf("script/target/output/%s/5a_train_lrn_%s.txt",version_id,version_id),
#             row.names = F, col.names = F, sep = " ")
# 
# write.table(seq.tgt_lrn_single_rot,sprintf("script/target/output/%s/6a_train_lrn_single_rot_%s.txt",version_id,version_id),
#             row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_base,sprintf("script/target/output/%s/0_tmp_train_base_clamp_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_base_before,sprintf("script/target/output/%s/0_tmp_train_base_clamp_before_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")
