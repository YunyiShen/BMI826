lcor <- function(x1, x2, s, l, 
                writeFile = FALSE, 
                filename = "leap problem5.txt", 
                append = FALSE){
    x1t <- x1[1:s]
    x2t <- x2[1:s+l]
    res <- cor(x1t,x2t)
    if(writeFile){
        sink(filename, append = append)
        cat("Lagged correlation\n")
        cat("x_i = [", x1, "]\n")
        cat("x_j = [", x2, "]\n")
        cat("Lagged correlation =",res,"\n\n")
        sink()
    }
    return(res)
}

lcor2 <- function(x2,x1,...){
    lcor(x1,x2,...)
}

# calculate the lcor from a source
reg_source <- function(exp_mat, time_vec, source_gene = 0, s = 300, l = 0, 
                writeFile = FALSE, 
                top_n = 10, 
                filename = "leap problem5.txt", 
                append = FALSE) {
    exp_mat <- t(exp_mat)
    n_gene <- ncol(exp_mat)
    if(length(time_vec)!=nrow(exp_mat)) stop("dimension mismatch for time and expression matrix")
    ind <- order(time_vec)
    exp_mat <- exp_mat[ind,]
    lcors <- apply(exp_mat, 2, lcor, exp_mat[,source_gene+1], s, l)
    ind <- rev(order(abs(lcors)))
    res <- data.frame(target = (1:n_gene-1)[ind], lagged_cor = lcors[ind])
    if(writeFile){
        sink(filename, append = append)
        cat("Top target of gene",source_gene, " with s =", s, "l =", l, "\n")
        for(i in 1:top_n){
            cat("Gene:", res$target[i], "\t",
                "Lagged correlation:", 
                res$lagged_cor[i], "\n")
        }
        cat("\n")
        sink()
    }
    return(res)
}

reg_source_file <- function(exp_file, time_file, time_ind = 2, ...){
    exp_mat <- read.table(exp_file)
    exp_mat <- as.matrix(exp_mat)
    time_vec <- as.numeric( read.table(time_file)[,time_ind])
    reg_source(exp_mat, time_vec, ...)
}

largest_l <- function(exp_mat, time_vec, 
                    source_gene = 15, 
                    target_gene = 8, 
                    s = 300, l = 0:10, writeFile = FALSE, 
                    filename = "leap problem5.txt", 
                    append = FALSE){
    
    exp_mat <- t(exp_mat)
    ind <- order(time_vec)
    exp_mat <- exp_mat[ind,]
    x1 <- exp_mat[,source_gene+1]
    x2 <- exp_mat[,target_gene+1]

    lcors <- sapply(l, function(l, s, x1, x2){
        lcor(x1,x2,s,l)
    },s, x1,x2)

    max_ind <- which.max(lcors)
    res <- l[max_ind]
    if(writeFile){
        sink(filename, append = append)
        cat("maximum lagged correlation is reached when l =", res, "\t", "the maximum is", max(lcors),"\n\n")
        sink()
    }
    return(res)
}

largest_l_file <- function(exp_file, time_file, time_ind = 2, ...){
    exp_mat <- read.table(exp_file)
    exp_mat <- as.matrix(exp_mat)
    time_vec <- as.numeric( read.table(time_file)[,time_ind])
    largest_l(exp_mat, time_vec, ...)
}



# calculate the lcor from a source
reg_target <- function(exp_mat, time_vec, target_gene = 63, s = 300, l = 0, 
                writeFile = FALSE, 
                top_n = 10, 
                filename = "leap problem5.txt", 
                append = FALSE) {
    exp_mat <- t(exp_mat)
    n_gene <- ncol(exp_mat)
    if(length(time_vec)!=nrow(exp_mat)) stop("dimension mismatch for time and expression matrix")
    ind <- order(time_vec)
    exp_mat <- exp_mat[ind,]
    lcors <- apply(exp_mat, 2, lcor2, exp_mat[,target_gene+1], s, l)
    ind <- rev(order(abs(lcors)))
    res <- data.frame(target = (1:n_gene-1)[ind], lagged_cor = lcors[ind])
    if(writeFile){
        sink(filename, append = append)
        cat("Top regulators of gene",target_gene, " with s =", s, "l =", l, "\n")
        for(i in 1:top_n){
            cat("Gene:", res$target[i], "\t",
                "Lagged correlation:", 
                res$lagged_cor[i], "\n")
        }
        cat("\n")
        sink()
    }
    return(res)
}

reg_target_file <- function(exp_file, time_file, time_ind = 2, ...){
    exp_mat <- read.table(exp_file)
    exp_mat <- as.matrix(exp_mat)
    time_vec <- as.numeric( read.table(time_file)[,time_ind])
    reg_target(exp_mat, time_vec, ...)
}



