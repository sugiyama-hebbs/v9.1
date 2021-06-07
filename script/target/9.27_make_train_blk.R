# make a train block from parts


seq_probe <- read.csv("script/target/output/part/0_probe_part_9.2.txt", header = F, sep=" ")
seq_lrn <- read.csv("script/target/output/part/0_train_z_0.7_lrn_9.27.txt", header = F, sep=" ")
seq_nlrn <- read.csv("script/target/output/part/0_train_z_0.7_nlrn_9.27.txt", header = F, sep=" ")
seq_base <- read.csv("script/target/output/part/0_train_z_0.7_baseline_9.27.txt", header = F, sep=" ")
seq_strat <- read.csv("script/target/output/part/0_train_z_0.7_strat_9.27.txt", header = F, sep=" ")

seq.tgt_lrn <- rbind(seq_probe,seq_lrn,seq_probe)
seq.tgt_nlrn <- rbind(seq_probe,seq_nlrn,seq_probe)
seq.tgt_base <- rbind(seq_probe,seq_base,seq_probe)
seq.tgt_strat <- rbind(seq_probe,seq_strat,seq_probe)

write.table(seq.tgt_lrn,sprintf("script/target/output/train_lrn_9.27.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn,sprintf("script/target/output/train_nlrn_9.27.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_base,sprintf("script/target/output/train_base_9.27.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_strat,sprintf("script/target/output/train_strat_9.27.txt"),
            row.names = F, col.names = F, sep = " ")



seq.tgt_lrn_no_pre <- rbind(seq_lrn,seq_probe)
seq.tgt_nlrn_no_pre <- rbind(seq_nlrn,seq_probe)
seq.tgt_base_no_pre <- rbind(seq_base,seq_probe)
seq.tgt_strat_no_pre <- rbind(seq_strat,seq_probe)

write.table(seq.tgt_lrn_no_pre,sprintf("script/target/output/train_lrn_no_pre_9.27.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_nlrn_no_pre,sprintf("script/target/output/train_nlrn_no_pre_9.27.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_base_no_pre,sprintf("script/target/output/train_base_no_pre_9.27.txt"),
            row.names = F, col.names = F, sep = " ")

write.table(seq.tgt_strat_no_pre,sprintf("script/target/output/train_strat_no_pre_9.27.txt"),
            row.names = F, col.names = F, sep = " ")