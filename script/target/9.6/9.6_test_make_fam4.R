# make a train block from parts

version_id <- "9.6"

seq_fam4 <- read.csv(sprintf("script/target/output/%s/0_fam_4_test_%s.txt",version_id,version_id), header = F, sep=" ")
seq_probe <- read.csv(sprintf("script/target/output/part/%s/0_probe_part_%s.txt",version_id,version_id), header = F, sep=" ")

seq.tgt_fam4 <- rbind(seq_probe,seq_fam4,seq_probe)

write.table(seq.tgt_fam4, sprintf("script/target/output/%s/test_fam4_%s.txt",version_id,version_id),
            row.names = F, col.names = F, sep = " ")
