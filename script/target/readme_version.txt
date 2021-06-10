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
  
  
9.29 1S1M, target jump (clamp)  
  .292 modified task difficulty for NLrn such that score roughly matches between the groups
  
9.30  experiment version
