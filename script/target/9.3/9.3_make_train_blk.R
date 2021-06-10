# make a train block from parts


seq_probe <- read.csv("script/target/output/part/0_probe_part_9.3.txt", header = F, sep=" ")
seq_lrn <- read.csv("script/target/output/part/0_train_lrn_9.3.txt", header = F, sep=" ")
seq_nlrn <- read.csv("script/target/output/part/0_train_nlrn_9.3.txt", header = F, sep=" ")

seq_lrn_break <- seq_lrn
seq_lrn_break[1,20] = 1
seq_nlrn_break <- seq_nlrn
seq_nlrn_break[1,20] = 1

seq.tgt_lrn_to_nlrn <- rbind(seq_probe,
                             seq_lrn,seq_probe,
                             seq_lrn_break,seq_probe)

seq.tgt_nlrn_to_lrn <- rbind(seq_probe,
                             seq_nlrn,seq_probe,
                             seq_nlrn_break,seq_probe)

write.table(seq.tgt_lrn_to_nlrn,sprintf("script/target/output/4_train_lrn_9.3.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn_to_lrn,sprintf("script/target/output/6_train_nlrn_9.3.txt"),
            row.names = F, col.names = F, sep = " ")

