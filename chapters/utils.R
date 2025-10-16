is_diff <- function(x, exclude = NULL){
    xt <- select(x, -all_of(exclude))
    nrow(distinct(xt)) > 1
}

fit_rma <- function(x, method){
    fit <- rma(yi, vi, data = x, method = method)
    #filor::summary_rma(fit)
    return(fit)
}

# to0 <- function(data, row, exclude = NULL){
#     common <- names(data)[names(data) %in% names(row)]
#     common <- c("rob", common)
#     MASK <- matrix(NA, nrow(data), length(common))
#     for(i in 1:length(common)){
#         col <- common[i]
#         if(row[[col]] == "all"){
#             mi <- rep(TRUE, nrow(data))
#         } else{
#             if(col == "rob"){
#                 if(row[[col]] == "rob_exclude_worst"){
#                     mi <- data$rob_exclude_worst == 1
#                 } else if(row[[col]] == "rob_include_best"){
#                     mi <- data$rob_include_best == 1
#                 }
#             }else{
#                 mi <- data[[col]] == row[[col]]
#             }
#         }
#         MASK[, i] <- mi
#     }
#
#     MASK <- as.integer(apply(MASK, 1, all))
#     ifelse(MASK == 1, 1, 0)
# }

to0 <- function(data, row, exclude = NULL){
    common <- names(data)[names(data) %in% names(row)]
    common <- c("rob", common)
    MASK <- matrix(NA, nrow(data), length(common))
    for(i in 1:length(common)){
        col <- common[i]
        if(row[[col]] == "all"){
            mi <- rep(TRUE, nrow(data))
        } else{
            if(col == "rob"){
                if(row[[col]] == "rob_exclude_worst"){
                    mi <- data$rob_exclude_worst == 1
                } else if(row[[col]] == "rob_include_best"){
                    mi <- data$rob_include_best == 1
                }
            }else{
                mi <- data[[col]] == row[[col]]
            }
        }
        MASK[, i] <- mi
    }

    MASK <- as.integer(apply(MASK, 1, all))
    ifelse(MASK == 1, 1, 0)
}

# get_tau2_h0 <- function(x){
#     if(x$method == "EE" | x$method == "FE"){
#         tau20 <- 0
#     } else{
#         dd <- x$data[x$subset, ]
#         yi <- dd$yi
#         vi <- dd$vi
#         id <- dd$study
#         fit0 <- rma.mv(yi, vi, random = ~ 1|id, beta = 0)
#         tau20 <- fit0$sigma2
#     }
#     return(tau20)
# }

get_tau2_h0 <- function(x = NULL, method = "REML"){
    if(method == "EE"){
        tau20 <- 0
    } else{
        if(!is.null(x)){
            yi <- x$yi
            vi <- x$vi
            id <- 1:length(yi)
            fit0 <- rma.mv(yi, vi, random = ~ 1|id, beta = 0)
            tau20 <- fit0$sigma2
        }
    }
    return(tau20)
}

aggregate_effects <- function(x, rho, subset){
    agg <- aggregate(x, cluster = study, rho = rho)
    agg |>
        mutate(es_id = 1:n())
}

eta2 <- function(fit){
    aov <- car::Anova(fit, type = "2")
    k <- nrow(aov) - 1
    sseff <- aov$`Sum Sq`
    sstot <- sum(aov$`Sum Sq`)
    etasq <- sseff/sstot
    data.frame(param = rownames(aov),
               eta2 = etasq,
               eta2per = etasq * 100)
}

tp <- function(p, type = "raw"){
    match.arg(type, choices = c("-log10", "z", "raw"))
    if(type == "-log10"){
        -log10(p)
    } else if(type == "z") {
        qnorm(1 - p/2)
    } else{
        p
    }
}

correct_pb <- function(x, method = "regtest"){
    if(method == "regtest"){
        fit <- regtest(x)
        nb <- fit$est
        ob <- x$b[[1]]
        x$data$yi <- with(x$data, yi - (ob - nb))
    }
    update(x, data = x$data)
}

pima <- function(x, method = "maxT", test = "t", subset = NULL, B = 1000){
    subset <- enexpr(subset)
    if(!is.null(subset)){
        x <- filter(x, !!subset)
    }
    # score matrix
    Z <- data.frame(x$zi)
    colnames(Z) <- paste0("m", 1:ncol(Z))
    rownames(Z) <- NULL

    fl <- flip(Z, statTest = test, perms = B)
    # adjusting p values with maxT
    fl <- flip.adjust(fl, method = "maxT")
    fl_res <- data.frame(fl@res)

    dd = bind_cols(
        x,
        fl_res
    )
    list(data = dd, flip = fl)
}

spec_curve <- function(x, ci = FALSE, subset = NULL){
    subset <- enexpr(subset)
    if(!is.null(subset)){
        x <- filter(x, !!subset)
    }
    top <- x |>
        ggplot(aes(x = specification, y = b, color = sign))

    if(ci){
        top <- top +
            geom_pointrange(aes(ymin = ci.lb, ymax = ci.ub))
    } else{
        top <- top +
            geom_point()
    }

    bottom <- x |>
        mutate(rho = paste("r =", rho)) |>
        pivot_longer(1:8) |>
        ggplot(aes(x = specification, y = value)) +
        geom_point() +
        facet_grid(name ~ ., scales = "free")

    top / bottom + plot_layout(heights = c(0.3, 1))
}


dplot <- function(data, col){
    ggplot(data, aes(x = b, fill = .data[[col]])) +
        geom_density() +
        theme(legend.position = "bottom",
              legend.title = element_blank()) +
        ggtitle(col)
}
