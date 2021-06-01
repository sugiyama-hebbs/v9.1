# make a train block from parts


seq_probe <- read.csv("script/target/output/part/0_probe_part_9.2.txt", header = F, sep=" ")
seq_lrn <- read.csv("script/target/output/part/0_train_low_z_3.5_lrn_9.21.txt", header = F, sep=" ")
seq_nlrn <- read.csv("script/target/output/part/0_train_low_z_3.5_nlrn_9.21.txt", header = F, sep=" ")

seq.tgt_lrn <- rbind(seq_probe,seq_lrn,seq_probe)
seq.tgt_nlrn <- rbind(seq_probe,seq_nlrn,seq_probe)

write.table(seq.tgt_lrn,sprintf("script/target/output/train_lrn_9.21.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn,sprintf("script/target/output/train_nlrn_9.21.txt"),
            row.names = F, col.names = F, sep = " ")