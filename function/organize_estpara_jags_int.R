
## Load library
library(dplyr)
library(purrr)

## preparation
num_sub = length(soi)

# jags_alpha_free_list = vector("list", num_sub)
# jags_alpha_fix_list = vector("list", num_sub)

train_est_beta_l <- vector("list", num_sub)
train_est_beta_no_e_l <- vector("list", num_sub) # no perceptual noise 
train_est_beta_no_e_tgt_l <- vector("list", num_sub) # no perceptual noise 
train_est_beta_no_e_tgt2_l <- vector("list", num_sub) # no perceptual noise 
train_est_beta_no_e2_l <- vector("list", num_sub) # no perceptual noise
train_est_beta_no_e2_fa_l <- vector("list", num_sub) # no perceptual noise

# normal priors
train_est_beta_no_e2_n1_l <- vector("list", num_sub) # no perceptual noise

train_est_beta_no_e2_n1_nx_l <- vector("list", num_sub) # no perceptual noise
train_est_beta_no_e2_n3_nx_l <- vector("list", num_sub) # no perceptual noise
train_est_beta_no_e2_un_nx_l <- vector("list", num_sub) # no perceptual noise

train_est_beta_no_e2_n3_l <- vector("list", num_sub) # no perceptual noise
train_est_beta_no_e2_n1_mp_l <- vector("list", num_sub) # no perceptual noise
train_est_beta_no_e2_n1_fa_l <- vector("list", num_sub) # no perceptual noise
train_est_beta_no_e2_n1_mx_l <- vector("list", num_sub) # update noise in m trial
train_est_beta_no_e2_n1_mx4_l <- vector("list", num_sub) # update noise in m trial

train_est_beta_no_ex_l <- vector("list", num_sub) # no perceptual or memory update noise 
train_est_beta_no_e_wo_l <- vector("list", num_sub) # no perceptual noise, no washout (trials without rotation)
train_est_beta_wo_l <- vector("list", num_sub) # no perceptual noise, washout only
train_est_beta_no_ex_wo_l <- vector("list", num_sub) # no perceptual/mem update noise, no washout (trials without rotation)
train_est_beta_triplet_l <- vector("list", num_sub)




## Read data 
csub = 0
for (sub in soi){

  csub = csub + 1
  
  ## Get data from csv file
  if (sub < 10){
    temp_str = sprintf("S0%d",sub) 
  } else {
    temp_str = sprintf("S%d",sub) 
  }
  fpath = sprintf("data/processed/%s",temp_str)
  
  train_est_beta_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta.csv", fpath),header = T) %>%
     dplyr::filter(val_type == "beta")
  
  train_est_beta_no_e_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_e_tgt_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e_tgt.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e_tgt2_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e_tgt2.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_e2_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")  
  
  train_est_beta_no_e2_fa_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_fa.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_e2_n1_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e2_n1_nx_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm_nx2.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e2_n3_nx_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm_nx3.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e2_un_nx_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_unif_nx.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e2_n3_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm3.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e2_n1_mp_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm_mp.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta") 
  
  train_est_beta_no_e2_n1_fa_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm_fa.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_e2_n1_mx_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm_mx.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
    train_est_beta_no_e2_n1_mx4_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e2_norm_mx4.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_ex_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_ex.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_e_wo_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e_no_wo.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_wo_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_e_wo.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_no_ex_wo_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_no_ex_no_wo.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  
  train_est_beta_triplet_l[[csub]]  <- read.csv(sprintf("%s/train_est_beta_triplet.csv", fpath),header = T) %>%
    dplyr::filter(val_type == "beta")
  # jags_alpha_fix_list[[csub]] = read.csv(sprintf("%s/est_para_jags_fix_alpha.csv", fpath),header = T) %>%
  #   dplyr::filter(val_type == "beta")
  # 
  # jags_alpha_free_list[[csub]] = read.csv(sprintf("%s/est_para_jags_exp2_train_free_alpha.csv", fpath),header = T)%>%
  #   dplyr::filter(val_type == "beta" | val_type == "alpha")
  
}

train_est_beta <- reduce(train_est_beta_l,rbind)
train_est_beta_no_e <- reduce(train_est_beta_no_e_l,rbind)
train_est_beta_no_e_tgt <- reduce(train_est_beta_no_e_tgt_l,rbind)
train_est_beta_no_e_tgt2 <- reduce(train_est_beta_no_e_tgt2_l,rbind)
train_est_beta_wo <- reduce(train_est_beta_wo_l,rbind)
train_est_beta_no_e2 <- reduce(train_est_beta_no_e2_l,rbind)
train_est_beta_no_e2_fa <- reduce(train_est_beta_no_e2_fa_l,rbind)
train_est_beta_no_e2_n1 <- reduce(train_est_beta_no_e2_n1_l,rbind)
train_est_beta_no_e2_n1_nx <- reduce(train_est_beta_no_e2_n1_nx_l,rbind)
train_est_beta_no_e2_n3_nx <- reduce(train_est_beta_no_e2_n3_nx_l,rbind)
train_est_beta_no_e2_un_nx <- reduce(train_est_beta_no_e2_un_nx_l,rbind)
train_est_beta_no_e2_n3 <- reduce(train_est_beta_no_e2_n3_l,rbind)
train_est_beta_no_e2_n1_mp <- reduce(train_est_beta_no_e2_n1_mp_l,rbind)
train_est_beta_no_e2_n1_fa <- reduce(train_est_beta_no_e2_n1_fa_l,rbind)
train_est_beta_no_e2_n1_mx <- reduce(train_est_beta_no_e2_n1_mx_l,rbind)
train_est_beta_no_e2_n1_mx4 <- reduce(train_est_beta_no_e2_n1_mx4_l,rbind)
train_est_beta_no_ex <- reduce(train_est_beta_no_ex_l,rbind)
train_est_beta_no_e_wo <- reduce(train_est_beta_no_e_wo_l,rbind)
train_est_beta_no_ex_wo <- reduce(train_est_beta_no_ex_wo_l,rbind)
train_est_beta_triplet <- reduce(train_est_beta_triplet_l,rbind)

# jags_alpha_fix = reduce(jags_alpha_fix_list,rbind)
# jags_alpha_free = reduce(jags_alpha_free_list,rbind)

