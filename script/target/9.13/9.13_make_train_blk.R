# make a train block from parts

version_id <- "9.13"

# seq_genuine <- read.csv(sprintf("script/target/output/part/%s/0_genuine_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_nlrn <- read.csv(sprintf("script/target/output/part/%s/0_train_nlrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_base <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_%s.txt",version_id,version_id), header = F, sep=" ")
seq_rand <- read.csv(sprintf("script/target/output/part/%s/0_train_rand_%s.txt",version_id,version_id), header = F, sep=" ")

seq_lrn_break <- seq_lrn
seq_lrn_break[1,20] = 1
seq_nlrn_break <- seq_nlrn
seq_nlrn_break[1,20] = 1
seq_base_break <- seq_base
seq_base_break[1,20] = 1

seq_probe_break <- seq_probe
seq_probe_break[26,20] <- 1 # hard coding. be careful about the # of pre-washouts and rotation trials

seq_probe_last <- seq_probe[(dim(seq_probe)[1]-9):(dim(seq_probe)[1]),]
seq.tgt_lrn <- rbind(seq_probe,
                     seq_base,seq_probe_break,
                     seq_lrn,seq_probe_break,
                     seq_lrn,seq_probe_break,
                     seq_lrn,seq_probe)

seq.tgt_nlrn <- rbind(seq_probe,
                     seq_base,seq_probe_break,
                     seq_nlrn,seq_probe_break,
                     seq_nlrn,seq_probe_break,
                     seq_nlrn,seq_probe)

seq.tgt_lrn_no_pre <- rbind(seq_probe_last,
                     seq_lrn,seq_probe_break,
                     seq_lrn,seq_probe_break,
                     seq_lrn,seq_probe)


write.table(seq.tgt_lrn,sprintf("script/target/output/%s/5a_train_lrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_lrn_no_pre,sprintf("script/target/output/%s/5a_train_lrn_no_pre_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn,sprintf("script/target/output/%s/5b_train_nlrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

