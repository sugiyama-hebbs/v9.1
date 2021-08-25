 2021/06/04
RMAmem v9 tgt version note


9.22 Snull -> Sptb -> M
  .222 shorter cycle (avg 5 M per cycle)

9.23 NoFB -> Sptb -> M

9.24 1S(n)M

9.25 1S1M
  .251 reduced z-val
  .252 modified wait-time between cycles and within a cycle
  .253 modified wait-time between cycles and within a cycle + reduced z-val
  .254 modified wait-time only when ptb switch + reduced z-val

9.26 1S(n)M, average M score at the end of each cycle (different python version)


9.27 1S1M, include Null-S (in this case, score calculation will be always NLrn)
  .272 no score in S-null -> M
  .273 removed S-null
  .274 longer M (higher z)

9.28 1S1M, varying rotation size (but "slope" of score changes remain fixed)
  .282 delay (0.8 -> 1sec) between cycles
  .283 .282 + 5-deg probe
  .284 longer delay between cycles, 5-deg
  .285 .284 - delay
  .286 half the training trials from .284  i.e., 2sec delay -> 0.8s delay
  .287 put back seed to the original one.
  .288 alternative rotatin flip (z=0)
  .289 target jump (TaskErr clamp)
  .2810 .289 + 0.8s delay between cycles


9.29 1S1M, target jump (clamp)
  .292 modified task difficulty for NLrn such that score roughly matches between the groups

9.3  experiment version (depreciated, 9.292 took over after testing TaskErr clamp that appears to work)

9.4 experiment version (identical to 9.292, just rename to avoid mixing with test versions)

9.5 experiment version (identical to 9.2810, just rename to avoid mixing with test versions)

9.6 experiment version
    modified from 9.4, mostly (but not limited to) familiarization, especially for solving a problem of drifting that is likely due to target jumping & clamping


9.7 pending experiment version
    copied from 9.6, attempting to add a practice block for forming TE-reward mapping
    (Also, Fam3 has not been fixed according to a discussion to make it "control" trials for Probe)

9.8 experiment version
    almost identical to 9.6, except the two following points
    a) Last part of Fam3 was changed to make it "control" trials for Probe (same contextual change, but no rotation)
    b) 1st two Train block has no score (i.e., baseline)

9.9 experiment version
    copied from 9.8, and change the rotation pattern in Train to even raise z (flip every 20 cycles)

9.10 experiment version
    copied from 9.9, and change the rotation pattern back to 9.8 (flip every 10 cycles).
    Modified Fam3 to random punishment
    one extra Train block
    Break after rotation in Probe, instead of the beginning of Intervention

9.11 experiment version
    copied from 9.10. Everything is the same, except that it's 1S4M in Intervention

9.12 experiment version
    copied from 9.11. S-null -> Sptb -> M (similar to 9.22).
    reduce pre-probe washout from 20 to 15

9.13 experiment version
    copied from 9.12 (but task-wise similar to 9.11).
    1S1M  x 10 -> null x 10

9.14 experiment version
    copied from 9.12. Sclamp -> Sptb -> M (Both direction)
    also has S-null -> Sptb -> M in one rotation direction

9.15 experiment version
    copied from 9.14. Sclamp -> Sptb_clamp -> M (Both direction)
    Score is based on delta-hand from Sptb to M instead of tgt - hand (performance) in M
    .152 identical to the original version, except that more Sclamp trialb in each cycle (and less cycles in each block instead)

9.160 test version
    5 Sptb-clamp -> 5 M-dhand-avg (+ error clamp)

9.16 experiment version
    copied from 9.160 with some modifications
    162 another experiment version. All intervention has 5 degree rotation (insteaf of 3-degree in the 1st half of intervention in the original)
    1630 experiment version. Intervention is the same as 162, but removed probes between intervention (This will be a control condition where potential confounding from experiencing washouts is controlled by removing washouts (and thereby probe as well, which cannot be done without washouts))
    1631 experiment version. Pretty much the same as 1630. Just adjusting task schedule based on 1630 (which is rather a test version)
    1632 experiment version. Task-wise the same as 1631, but the schedule is changed such that blocks are organized as sets of washout -> NR->(N)Lrn->NR.
9.17 experiment version
     copied from 9.162. Some modifications:
      a) 5S -> 5M -> 10 Null, reference memory from last 5 Null
      b) 10 Sclamp in before rotation trials in Probe (between Pre-washout, more precisely speaking)
      c) 10 Sclamp right after rotation in Probe to measure decay
      d) only one rotation direction in Intervention

    .172 the following modifications from the original version
    a)  change pre-clamp to normal washouts
    b) change Sjump to Snull in Intervention
    c) target-jump in the 5 trials before rotations in Probe (mistakenly not implemented. Will be tested in the next version)
    d) narrow target direcion in Post-clamp in Probe

    .173 the following changes from the .172
    a) target-jump in the 5 trials before rotations in Probe
    b) task schedule has longer and less # of blocks
    
    .1731 reference memory taken from the 1st S trial. Also not punishing undershoot in NLrn

    .174 the following changes from the .173
    a) modified # of S and M trial (1S3M, for example)
    b) allow overshoot for Learn (no punishing)
    .1741 identical to .174, except that # of S is increased from 1 to 3 per cycle
    .1742 identical to .174, except that # of S is increased from 1 to 5 per cycle

    .17401, .17411, .17421 identical to the corresponding sub-version. Changed task sequence to make it from within to between

    .1750 test version with the following changes from the .173
    S and M are alternating instead of consecutive. There are two test versions, one taking reference memory in S trial and the other taking the average of S and last M (to alleviate effects of motor noise in scoring)
    .175 experiment version. Selected the test version with reference memory in S trial * NLrn allows undershoot from S37. Original NLrn sequence is stored in "old" subdirectory
    
    .1752 experiment version. Remove cursor from M trial.
    
     .1752 experiment version. Remove cursor from M trial (same as .1752), and score calculation is in "absolute" scale (whereas it is relative to last hand direction in the original).
