# make a train block from parts

version_id <- "9.1632"

seq_fam_2 <- read.csv(sprintf("script/target/output/%s/3_fam_2_%s.txt",version_id,version_id), header = F, sep=" ")

seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_nlrn <- read.csv(sprintf("script/target/output/part/%s/0_train_nlrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_base <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_%s.txt",version_id,version_id), header = F, sep=" ")

seq_base_half <- seq_base[1:(dim(seq_base)[1]/2),]
seq_wo <- seq_fam_2[1:20,] # initial washout at the very beginning


idx_training_type <- 14
seq_wo[,idx_training_type] <- 99

# seq_lrn_break <- seq_lrn
# seq_lrn_break[1,20] <- 1
# seq_nlrn_break <- seq_nlrn
# seq_nlrn_break[1,20] <- 1
# seq_base_break <- seq_base
# seq_base_break[1,20] <- 1
seq_wo_break <- seq_wo
seq_wo_break[1,20] <- 1


seq_lrn_tmp_break <- seq_lrn_tmp
seq_lrn_tmp_break[1,20] <- 1

# seq_probe_break <- seq_probe
# seq_probe_break[26,20] <- 1 # hard coding. be careful about the # of pre-washouts and rotation trials



seq.tgt_lrn <- rbind(seq_wo,seq_base_half,seq_lrn,seq_base_half,
                     seq_wo_break,seq_base_half,seq_lrn,seq_base_half,
                     seq_wo_break,seq_base_half,seq_lrn,seq_base_half,
                     seq_wo_break,seq_base_half,seq_nlrn,seq_base_half,
                     seq_wo_break,seq_base_half,seq_nlrn,seq_base_half,
                     seq_wo_break,seq_base_half,seq_nlrn,seq_base_half) 


seq.tgt_nlrn <- rbind(seq_wo,seq_base_half,seq_nlrn,seq_base_half,
                      seq_wo_break,seq_base_half,seq_nlrn,seq_base_half,
                      seq_wo_break,seq_base_half,seq_nlrn,seq_base_half,
                      seq_wo_break,seq_base_half,seq_lrn,seq_base_half,
                      seq_wo_break,seq_base_half,seq_lrn,seq_base_half,
                      seq_wo_break,seq_base_half,seq_lrn,seq_base_half) 



dir.create(file.path("script/target/output",version_id), showWarnings = F)

write.table(seq.tgt_lrn,sprintf("script/target/output/%s/5a_train_lrn_to_nlrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")
write.table(seq.tgt_nlrn,sprintf("script/target/output/%s/5b_train_nlrn_to_lrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")
