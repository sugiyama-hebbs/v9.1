# make a train block from parts


seq_probe <- read.csv("script/target/output/part/0_probe_part_9.2.txt", header = F, sep=" ")
seq_lrn <- read.csv("script/target/output/part/0_train_low_z_5_lrn_9.24.txt", header = F, sep=" ")
seq_nlrn <- read.csv("script/target/output/part/0_train_low_z_5_nlrn_9.24.txt", header = F, sep=" ")
seq_strat <- read.csv("script/target/output/part/0_train_low_z_5_strat_9.24.txt", header = F, sep=" ")

seq.tgt_lrn <- rbind(seq_probe,seq_lrn,seq_probe)
seq.tgt_nlrn <- rbind(seq_probe,seq_nlrn,seq_probe)
seq.tgt_strat <- rbind(seq_probe,seq_strat,seq_probe)

write.table(seq.tgt_lrn,sprintf("script/target/output/train_lrn_9.24.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn,sprintf("script/target/output/train_nlrn_9.24.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_strat,sprintf("script/target/output/train_strat_9.24.txt"),
            row.names = F, col.names = F, sep = " ")



seq.tgt_lrn_no_pre <- rbind(seq_lrn,seq_probe)
seq.tgt_nlrn_no_pre <- rbind(seq_nlrn,seq_probe)
seq.tgt_strat_no_pre <- rbind(seq_strat,seq_probe)

write.table(seq.tgt_lrn_no_pre,sprintf("script/target/output/train_lrn_no_pre_9.24.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn_no_pre,sprintf("script/target/output/train_nlrn_no_pre_9.24.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_strat_no_pre,sprintf("script/target/output/train_strat_no_pre_9.24.txt"),
            row.names = F, col.names = F, sep = " ")


seq_lrn_break <- seq_lrn
seq_lrn_break[1,20] = 1
seq_nlrn_break <- seq_nlrn
seq_nlrn_break[1,20] = 1

seq.tgt_lrn_to_nlrn <- rbind(seq_probe,
                             seq_lrn,seq_probe,
                             seq_lrn_break,seq_probe,
                             seq_lrn_break,seq_probe,
                             seq_nlrn_break,seq_probe,
                             seq_nlrn_break,seq_probe,
                             seq_nlrn_break,seq_probe)



seq.tgt_nlrn_to_lrn <- rbind(seq_probe,
                             seq_nlrn,seq_probe,
                             seq_nlrn_break,seq_probe,
                             seq_nlrn_break,seq_probe,
                             seq_lrn_break,seq_probe,
                             seq_lrn_break,seq_probe,
                             seq_lrn_break,seq_probe)


write.table(seq.tgt_lrn_to_nlrn,sprintf("script/target/output/train_lrn3_to_nlrn3_9.24.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn_to_lrn,sprintf("script/target/output/train_nlrn3_to_lrn3_9.24.txt"),
            row.names = F, col.names = F, sep = " ")

