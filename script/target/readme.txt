2021/4/13
RMAMem v8.1 target scripts


## Format
# 1 = field: force-field type (0=Null, 1=Viscous FF, 3=Channel) * 2 is currently not used
# 2 = apply_field: (not really used. maybe just remove)
# 3 = target radius: distance between the start and the shoot boundary (target)
# 4 = target degree: target direction
# 5 = wait_time in second. (corresponds to ITI)
# 6 = b_value: viscous force value (constant)
# 7 = channel_k11: channel force (not really used. maybe just remove)
# 8 = channel_B11: channel force (not really used. maybe just remove)
# 9 = gain for spring force during movement. Usually set to 0  (except "pseudo" isometric force task, maybe)
# 10 = rot_degree: cursor rotation in degree
# 11 = show_arc: whether to present an arc instead of a point target. 2 will remove the arc at movement initiation. 3 will give aiming markers on the sides. 4~5 gives a brief flash target. 6 will give a target jumping to the cursor direction (claming) at crossing. 7 gives a target flash + non-jumping (genuine) target at crossing * currently hide target in M trial, which is not an ideal control (7/6/2021) that will be changed
# 12 = show_cur: whether to show cursor. 0=no, 1=online, 2=slit (specifically for this task, depreciated),3=clamp
# 13 = show_score: whether to show score. 2 gives random punishment
# 14 = training_type: type of meta-learning training. 1: Lrn, 2: NLrn, 3: Reward-based (not a meta-learning training, but rather a control condition). 11: Lrn-dhand, 12: NLrn-dhand Baseline: 99, 21: Lrn-dhand-avg, 22:NLrn-dhand-avg. 31-Lrn-dhand-avg-allow_overshoot (not punishing overshoot), 32-NLrn-dhand-avg-allow_undershoot (not punishing undershoot)
# 15 = minimum_score: min score that can be earned in a trial
# 16 = maximum_score: max score that can be earned in a trial
# 17 = difficulty: constant defining how much point is reduced per 10% of learning wrt last experienced rotation (e.g., if this is 3 and you're 20% off from the ideal learning amount (100% in Lrn and 0% in NLrn), you get 3 x 20%/10% = 6 points less)
# 18 = trial type: 1: Visuomotor, 2: S, 3: M, 4: Rwd-based, 5: S-count-error (for Lrn/NLrn-dhand-avg), 6: M-count-error (for Lrn/NLrn-dhand-avg), 7: S-count-error, reset before update, 8: M-count-error, reset before update., 9: S-count-error-set, set reference error, 10: M-count-error-set, set reference error
# 19 = block phase: block phase. Probably not used in the task, but useful in analyses
# 20 = task_break. insert a pause as break at the BEGINNING of a trial with this set to 1
/////// the notes below are from the previous version. It will be edited as they are edited later //////// 

To insert/add probe and other phases to train block as the task schedule is designed, each phase is generated separately at the beginning, and then later it's combined by another script.

This is to make sure that each phase is indentical, regardless of block

1. Run "create_tgt_7.17.R" and  "create_tgt_7.17_probe.R"
2. Run "merge_phase"
