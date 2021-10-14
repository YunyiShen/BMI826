args <- commandArgs(trailingOnly=TRUE)
set.seed(42)
source("helper.R")

# question A
lcor(1:6,c(8, 4, 3, 0, 1, 7), 6,0, writeFile = T, append = T)
lcor(1:6,c(8, 4, 3, 0, 1, 7), 3,0, writeFile = T, append = T)
lcor(1:6,c(8, 4, 3, 0, 1, 7), 3,3, writeFile = T, append = T)

lcor(rnorm(6),rnorm(6), 6,0, writeFile = T, append = T)
lcor(runif(6),runif(6), 6,0, writeFile = T, append = T)
lcor(rgamma(6,1,1),rgamma(6,1,1), 6,0, writeFile = T, append = T)

# question B

exp_file <- "./data/exp_train.txt"
time_file <- "./data/time_train.txt"

reg_source_file(exp_file, time_file, s = 300, l = 0, writeFile = T, append = T)

# question C
reg_source_file(exp_file, time_file, s = 300, l = 25, writeFile = T, append = T)

# question D
reg_source_file(exp_file, time_file, s = 100, l = 25, writeFile = T, append = T)

# question E
largest_l_file(exp_file, time_file, source_gene = 15, 
                target_gene = 8, writeFile = T, append = T)

# question F
reg_target_file(exp_file, time_file, s = 300, l = 0, writeFile = T, append = T)
reg_target_file(exp_file, time_file, s = 300, l = 25, writeFile = T, append = T)
