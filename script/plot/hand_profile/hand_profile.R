# hand direction is based on the edge of slit (8cm), so plots look slightly different from ones made in initial processing

unique_sub_tag <- "s01_2" # you can set your own specific subject id/tag in string. Set NA if you don't need this feature
slit_inner_edge <- 0.08 # distance of the inner slit edge from the start (m). hard coding 
init_tri_remove <- 5
last_tri_remove <- 5

main_dir = "hand_profile"

sub_dir = unique_sub_tag
# num_wo_inc <- 5 # number of preceding washouts to be included in fitting

## Preparation
library(dplyr)
library(ggplot2)
library(purrr)
library(nloptr)
library(Biobase) # Be careful about using this package, as it will mask many functions
library(gridExtra)
source("function/format_gg.R")
source("function/gg_def_col.R")
source("function/save_plots.R")

tgt_dir <- unique_sub_tag # copy

## Read and organize data

load(sprintf("data/processed/%s/exp_data.Rdata",tgt_dir)) # File path

df_point_load <- output_list$point
df_tgt_load <- output_list$tgt


# get hand direction at the inner slit
df_hand_slit <- output_list$kin %>% 
  dplyr::select(blk_tri,x,y) %>% 
  mutate(dist = sqrt(x^2 + y^2)) %>% 
  dplyr::filter(dist >= slit_inner_edge) %>% 
  group_by(blk_tri) %>% 
  dplyr::filter(row_number() ==1) %>% 
  ungroup() %>% 
  mutate(hand_slit = atan2(y,x)*180/pi) %>% 
  dplyr::select(blk_tri,hand_slit)


df_point <- dplyr::select(df_point_load, blk_tri, cross_deg_rbt) %>%
  dplyr::rename(hand = cross_deg_rbt)

df_tgt <- dplyr::select(df_tgt_load, blk_tri,tgt,show_cur,show_arc,rot,block_phase)


df_data <- left_join(df_point,df_tgt, by="blk_tri") %>% 
  left_join(df_hand_slit, by="blk_tri") %>% 
  mutate(herr = tgt - hand_slit, 
         terr = tgt - (hand_slit + rot), 
         tgt_f = factor(tgt)) 

## Plot Hand
num_tgt <- length(unique(df_data$tgt))

colfunc <- colorRampPalette(c("magenta", "cyan"))


plot1.pre <- ggplot(df_data, aes(x = blk_tri)) +
  geom_line(data = subset(df_data, show_cur != 0), aes(y=rot), color="orange") +
  geom_line(aes(y=herr), color="black") +
  geom_point(aes(y=herr, color = tgt_f)) +
  scale_color_manual(values = colfunc(num_tgt), name = "Tgt Dir")

plot1 <- format_gg(plot1.pre, xlabel = "Trial", ylabel = "Direction [deg]", 
                   ptitle = "Aligned Hand Direction (Error), Colored by Target", 
                   xlimit=(range(df_data$blk_tri)+c(-1,1)), ylimit = c(-15,15), 
                   expand_coord = F)

save_plots(tgt_plot = plot1, mdir = main_dir, sdir = sub_dir, fname = "hand", pdf_only = T, readme_content = "") 

plot2.pre <- ggplot(df_data, aes(x = blk_tri)) +
  geom_line(data = subset(df_data, show_cur != 0), aes(y=rot), color="orange") +
  geom_line(aes(y=herr), color="black") +
  geom_point(aes(y=herr), color="black") 

plot2 <- format_gg(plot2.pre, xlabel = "Trial", ylabel = "Direction [deg]", 
                   ptitle = "Aligned Hand Direction (Error), Colored by Target", 
                   xlimit=(range(df_data$blk_tri)+c(-1,1)), ylimit = c(-15,15), 
                   expand_coord = F)

save_plots(tgt_plot = plot2, mdir = main_dir, sdir = sub_dir, fname = "hand_no_color", pdf_only = T, readme_content = "") 



# plot3.pre <- ggplot(subset(df_data,tgt >=85 & tgt <=105), aes(x = blk_tri)) +

tmp_dir = 105
plot3.pre <- ggplot(subset(df_data,tgt == tmp_dir), aes(x = blk_tri)) +
# plot3.pre <- ggplot(subset(df_data,tgt <85 | tgt >105), aes(x = blk_tri)) +
  geom_line(data = subset(df_data, show_cur != 0), aes(y=rot), color="orange") +
  geom_line(aes(y=herr), color="black") +
  geom_point(aes(y=herr, color = tgt_f)) +
  scale_color_manual(values = colfunc(num_tgt), name = "Tgt Dir")

plot3 <- format_gg(plot3.pre, xlabel = "Trial", ylabel = "Direction [deg]", 
                   ptitle = sprintf("Aligned Hand Direction (Error), Colored by Target (%d)",tmp_dir), 
                   xlimit=(range(df_data$blk_tri)+c(-1,1)), ylimit = c(-15,15), 
                   expand_coord = F)

plot3

# save_plots(tgt_plot = plot3, mdir = main_dir, sdir = sub_dir, fname = "hand_sub", pdf_only = T, readme_content = "") 
