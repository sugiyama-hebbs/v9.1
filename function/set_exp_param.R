# Set basic experiment parameters
# Make sure that all the values are set properly when you copy and paste the anaysis scripts from one paradigm to another
#
# Author: Taisei Sugiyama

all_subs <- c(51:52,54:71,73:101,201:214,301:306,401:402,404:406) # All subject ids to be included
# all_subs <- c(51:52,54:71,73:101,201:214) # All subject ids to be included
new_subs <- 401:402
plot_fitres <- "none" # control plotting results for individual fit. "all" to plot all subjects, "new" to only specified (new) subjects, "none" (or any non-matching string) to skip
# plot_fitres <- "all" # control plotting results for individual fit. "all" to plot all subjects, "new" to only specified (new) subjects, "none" (or any non-matching string) to skip

sub_exclude_vm <- c(57,77,84)

return_ryu <- c(52,54:58,60:63,65,71,73:74,81) # those participating in decision-making before this task
return_sub <- c(return_ryu,59, 64,86:89,91,92,99,301:306,401:402,404:406) # those participating in decision-making before this task

# hard code for now. later automated
# subs_lrn <- c(51:54,57,62,64,66,67,69,71,73,74,78,81)
# subs_nlrn <- c(55:56,58,59:61,63,65,68,70,75:77,79,80)

phase_prb <- 7 # probe phase number
phase_visuo <- c(5,6) # visuomotor rotation phase number 
baseblk <- 6 # Baseline block number
trainblk = 7:9
rwdblk <- c(5,6,9) # blocks with reward-based learning phase
visuoblk <- c(6,9)
visuoblk_extra <- 10
probeblk <- 6:9 # blocks with probe phase

n_rwd_base_norot <- 10 # number of no rotation trials in a reward-based phase
n_rwd_base_rot <- 10 # number of rotation trials in a reward-based phase (no rotation in pre-training, but treating them in the same way)


#### Following params may need to be edited, as they are copied from the previous version (v1.11)
phase_pre <- 2 # Pre-Intervention Probe phase (only in Baseline)
phase_int <- 4 # Intervention phase
phase_pos <- 6 # Post-Intervention Probe phase
rpc <- 4 # number of R-trials per cycle


# init_boi <- 2 # Initial block of interest (correspond to the 1st BL block)
# last_boi <- 6 # Last block of interest. For now, the extra block(7) is removed
# num_boi <- last_boi - init_boi + 1 # Number of blocks of interest. 
# num_prb <- num_boi + 1 # Number of probe Sets. Add one for pre-prob

# phase1 <- 3:4 # Early train phase
# phase2 <- 5:6 # Late train phase
# trainblk <- 3:6 # Train blocks

num_cyc <- 28 # number of cycles per train block
# baseblk <- 2 # Baseline block number

tri_per_cyc <- 5 # trials per Train cycle
cyc_per_blk <- 28 # number of Train cycles per block
seg_per_phase <- 4 # number of segment per Probe phase

tri_per_seq =  5# number of rotation trials per a sequence in Generalization

prb_first_half <- 15 # number of probe trials considered the 1st half (5 ptb_1 + 5 washout + 5 ptb_2  = 15 trials)
prb_second_half <- 15 # number of probe trials considered the 2st half (5 ptb_3 + 5 washout + 5 ptb_4  = 15 trials)
tgt_width <- 5 # target width in mm

iv1_levels <- c("Go","Nogo") # task demand
iv2_levels <- c("Avoid") # valence

plot_label <- c("Lrn-Rwd","Lrn-Pun","NLrn-Rwd","NLrn-Pun","No Rwd","Rand Pun") # this is not tested, use with caution
plot_label_noval <- c("Lrn","NLrn","No Rwd","Rand Pun") # this is not tested, use with caution

plot_name_iv1 <- "AO Structure"
plot_name_iv2 <- "Valence"



# old coloring (version 1.11)
pcol_4grp <- c("#ce3660","#e7211f","#9ecd6d","#2a4097")

# temporary line to suppress dplyr summarise message
options(dplyr.summarise.inform = FALSE)

