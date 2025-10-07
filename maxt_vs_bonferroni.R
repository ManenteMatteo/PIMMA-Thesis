set.seed(3290)
library(flip)
library(filor)
library(devtools)
library(dplyr)
library(ggplot2)
library(tidyr)


r <- c(0, 0.3, 0.5, 0.9)
nsim <- 1e3
n <- 1e4
k <- 30

mu <- runif(k, 0, 0.5)
res <- vector(mode = "list", length = length(r))

for(i in 1:length(r)){
    R <- filor::rmat(rep(r[i], filor::ncor(k)))
    Y <- MASS::mvrnorm(k, mu, R, empirical = TRUE)
    fl <- flip::flip(Y)
    fl <- flip.adjust(fl)
    p_maxt <- fl@res$`Adjust:maxT`
    p_raw <- fl@res$`p-value`
    p_bonf <- p.adjust(p_raw, method = "bonferroni")
    res[[i]] <- list(p = p_raw, p_maxt = p_maxt, p_bonf = p_bonf)
}

names(res) <- r
res <- bind_rows(res, .id = "rho")
res$rho <- factor(res$rho, labels = latex2exp::TeX(sprintf("$\\rho = %s$", r)))

res |>
    pivot_longer(c(p_maxt, p_bonf)) |>
    mutate(name = ifelse(name == "p_bonf", "Bonferroni", "maxT")) |>
    ggplot(aes(x = p, y = value, color = name)) +
    geom_point(size = 3) +
    facet_wrap(~rho, labeller = label_parsed) +
    geom_abline(lty = "dashed", linewidth = 0.3) +
    geom_line() +
    xlab("Raw p-value") +
    ylab("Corrected p-value") +
    theme_minimal(base_size = 17) +
    theme(legend.position = "bottom",
          legend.title = element_blank()) +
    xlim(c(0,1)) +
    ylim(c(0,1))
