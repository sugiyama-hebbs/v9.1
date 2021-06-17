# make a train block from parts

version_id <- "9.9"

# seq_genuine <- read.csv(sprintf("script/target/output/part/%s/0_genuine_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")
seq_lrn <- read.csv(sprintf("script/target/output/part/%s/0_train_lrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_nlrn <- read.csv(sprintf("script/target/output/part/%s/0_train_nlrn_%s.txt",version_id,version_id), header = F, sep=" ")
seq_base <- read.csv(sprintf("script/target/output/part/%s/0_train_baseline_%s.txt",version_id,version_id), header = F, sep=" ")

seq_lrn_break <- seq_lrn
seq_lrn_break[1,20] = 1
seq_nlrn_break <- seq_nlrn
seq_nlrn_break[1,20] = 1
seq_base_break <- seq_base
seq_base_break[1,20] = 1

seq.tgt_lrn_to_nlrn <- rbind(seq_probe,
                             seq_base,seq_probe,
                             seq_base_break,seq_probe,
                             seq_lrn_break,seq_probe,
                             seq_lrn_break,seq_probe)

seq.tgt_nlrn_to_lrn <- rbind(seq_probe,
                             seq_base,seq_probe,
                             seq_base_break,seq_probe,
                             seq_nlrn_break,seq_probe,
                             seq_nlrn_break,seq_probe)

write.table(seq.tgt_lrn_to_nlrn,sprintf("script/target/output/%s/5a_train_lrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn_to_lrn,sprintf("script/target/output/%s/5b_train_nlrn_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")

