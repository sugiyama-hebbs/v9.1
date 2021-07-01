# make a train block from parts

version_id <- "9.1631"

# seq_genuine <- read.csv(sprintf("script/target/output/part/%s/0_genuine_part_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_fam_2 <- read.csv(sprintf("script/target/output/%s/3_fam_2_%s.txt",version_id,version_id), header = F, sep=" ")

seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_lrn_tmp <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_retro_m_%s.txt",version_id,version_id), header = F, sep=" ")
seq_nlrn <- read.csv(sprintf("script/target/output/part/%s/0_train_nlrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_base <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_rand <- read.csv(sprintf("script/target/output/part/%s/0_train_rand_%s.txt",version_id,version_id), header = F, sep=" ")

# seq_lrn_clamp <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_clamp_%s.txt",version_id,version_id), header = F, sep=" ")
# seq_base_clamp <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_clamp_%s.txt",version_id,version_id), header = F, sep=" ")

seq_wo <- seq_fam_2[1:10,] # initial washout at the very beginning

seq_lrn_break <- seq_lrn
seq_lrn_break[1,20] = 1
seq_nlrn_break <- seq_nlrn
seq_nlrn_break[1,20] = 1
seq_base_break <- seq_base
seq_base_break[1,20] = 1

seq_lrn_tmp_break <- seq_lrn_tmp
seq_lrn_tmp_break[1,20] = 1

# seq_probe_break <- seq_probe
# seq_probe_break[26,20] <- 1 # hard coding. be careful about the # of pre-washouts and rotation trials



seq.tgt_lrn <- rbind(seq_wo,
                     seq_base,seq_base_break,seq_base_break,
                     seq_lrn_break,seq_lrn_break,seq_lrn_break,seq_lrn_break,seq_lrn_break,
                     seq_base_break) 


seq.tgt_nlrn <- rbind(seq_wo,
                      seq_base,seq_base_break,seq_base_break,
                      seq_nlrn_break,seq_nlrn_break,seq_nlrn_break,seq_nlrn_break,seq_nlrn_break,
                      seq_base_break) 


seq.tgt_tmp <- rbind(seq_wo,
                     seq_lrn,seq_lrn_break,
                     seq_lrn_tmp_break,seq_lrn_tmp_break) 


dir.create(file.path("script/target/output",version_id), showWarnings = F)

write.table(seq.tgt_lrn,sprintf("script/target/output/%s/5a_train_lrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")
write.table(seq.tgt_nlrn,sprintf("script/target/output/%s/5b_train_nlrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_tmp,sprintf("script/target/output/%s/tmp_train_mix_retro_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

