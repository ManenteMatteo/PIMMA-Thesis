# Multiverse Meta-Analysis: Proposal of a New Inferential Approach with an Application to Depression Psychotherapy

## Authors:
Manente, M., Altoè, G., Gambarota, F.

---

## **Description**

This project contains the material for the thesis titled *“Multiverse Meta-Analysis: Proposal of a New Inferential Approach with an Application to Depression Psychotherapy”*, written in Quarto.  

The thesis addresses the issue of **replicability in psychological research**, introducing the application of the **inferential approach PIMA (Post-Selection Inference in Multiverse Analysis)** to **Multiverse Meta-Analysis**.  

In particular, it proposes an application of PIMA to meta-analyses (**PIMMA**), including practical examples and visualizations of the results obtained.

---

## **How to Reproduce the Work**

0. Install [Quarto](https://quarto.org/)
1. Download the folder **`PIMMA_Thesis_Manente_Matteo`** and extract it.
2. Inside the folder, open the file **`PIMMA_Thesis.Rproj`** with RStudio.
3. Set the **Working Directory** to the main folder **`PIMMA_Thesis_Manente_Matteo`**.
4. Open any file within the **`chapters`** folder (e.g., `chapter1.qmd`).
5. Make sure you have installed the required R packages (see *System Specifications > Packages*).
6. Render the file (e.g., `chapter1.qmd`) by clicking **“Render”** within RStudio.

---

## **System Specifications**
setting  value
 version  R version 4.5.1 (2025-06-13)
 os       Pop!_OS 22.04 LTS
 system   x86_64, linux-gnu
 ui       X11
 language (EN)
 collate  en_US.UTF-8
 ctype    en_US.UTF-8
 tz       Europe/Rome
 date     2025-06-20
 pandoc   3.4 @ /usr/lib/rstudio/resources/app/bin/quarto/bin/tools/x86_64/ (via rmarkdown)
 quarto   1.6.40 @ /usr/local/bin/quarto

─ Packages ──────────────────────────────────────────────────────────────────────────────
 package     * version    date (UTC) lib source
 abind         1.4-8      2024-09-12 [1] CRAN (R 4.5.0)
 askpass       1.2.1      2024-10-04 [1] CRAN (R 4.5.0)
 bitops        1.0-9      2024-10-03 [1] CRAN (R 4.5.0)
 boot          1.3-31     2024-08-28 [4] CRAN (R 4.4.2)
 car           3.1-3      2024-09-27 [1] CRAN (R 4.5.0)
 carData     * 3.0-5      2022-01-06 [1] CRAN (R 4.5.0)
 cherry        0.6-15     2025-01-17 [1] CRAN (R 4.5.0)
 cli           3.6.4      2025-02-13 [1] CRAN (R 4.5.0)
 colorspace    2.1-1      2024-07-26 [1] CRAN (R 4.5.0)
 DBI           1.2.3      2024-06-02 [1] CRAN (R 4.5.0)
 digest        0.6.37     2024-08-19 [1] CRAN (R 4.5.0)
 dplyr       * 1.1.4      2023-11-17 [1] CRAN (R 4.5.0)
 effects     * 4.2-2      2022-07-13 [1] CRAN (R 4.5.0)
 evaluate      1.0.3      2025-01-10 [1] CRAN (R 4.5.0)
 farver        2.1.2      2024-05-13 [1] CRAN (R 4.5.0)
 fastmap       1.2.0      2024-05-15 [1] CRAN (R 4.5.0)
 filor         0.1.0      2025-06-12 [1] local
 flip        * 2.5.1      2025-04-21 [1] CRAN (R 4.5.0)
 forcats     * 1.0.0      2023-01-29 [1] CRAN (R 4.5.0)
 Formula       1.2-5      2023-02-24 [1] CRAN (R 4.5.0)
 fs            1.6.6      2025-04-12 [1] CRAN (R 4.5.0)
 gargle        1.5.2      2023-07-20 [1] CRAN (R 4.5.0)
 generics      0.1.3      2022-07-05 [1] CRAN (R 4.5.0)
 ggplot2     * 3.5.2      2025-04-09 [1] CRAN (R 4.5.0)
 glue          1.8.0      2024-09-30 [1] CRAN (R 4.5.0)
 googledrive   2.1.1      2023-06-11 [1] CRAN (R 4.5.0)
 gtable        0.3.6      2024-10-25 [1] CRAN (R 4.5.0)
 hms           1.1.3      2023-03-21 [1] CRAN (R 4.5.0)
 hommel        1.8        2025-01-14 [1] CRAN (R 4.5.0)
 htmltools     0.5.8.1    2024-04-04 [1] CRAN (R 4.5.0)
 htmlwidgets   1.6.4      2023-12-06 [1] CRAN (R 4.5.0)
 insight       1.2.0      2025-04-22 [1] CRAN (R 4.5.0)
 jsonlite      2.0.0      2025-03-27 [1] CRAN (R 4.5.0)
 knitr         1.50       2025-03-16 [1] CRAN (R 4.5.0)
 labeling      0.4.3      2023-08-29 [1] CRAN (R 4.5.0)
 latex2exp     0.9.6      2022-11-28 [1] CRAN (R 4.5.0)
 lattice       0.22-5     2023-10-24 [4] CRAN (R 4.3.1)
 lifecycle     1.0.4      2023-11-07 [1] CRAN (R 4.5.0)
 lme4          1.1-37     2025-03-26 [1] CRAN (R 4.5.0)
 lpSolve       5.6.23     2024-12-14 [1] CRAN (R 4.5.0)
 lubridate   * 1.9.4      2024-12-08 [1] CRAN (R 4.5.0)
 magrittr      2.0.3      2022-03-30 [1] CRAN (R 4.5.0)
 MASS          7.3-65     2025-02-28 [4] CRAN (R 4.4.3)
 mathjaxr      1.6-0      2022-02-28 [1] CRAN (R 4.5.0)
 Matrix      * 1.7-3      2025-03-11 [4] CRAN (R 4.4.3)
 metadat     * 1.4-0      2025-02-04 [1] CRAN (R 4.5.0)
 metafor     * 4.8-0      2025-01-28 [1] CRAN (R 4.5.0)
 minqa         1.2.8      2024-08-17 [1] CRAN (R 4.5.0)
 mitools       2.4        2019-04-26 [1] CRAN (R 4.5.0)
 munsell       0.5.1      2024-04-01 [1] CRAN (R 4.5.0)
 nlme          3.1-168    2025-03-31 [4] CRAN (R 4.4.3)
 nloptr        2.2.1      2025-03-17 [1] CRAN (R 4.5.0)
 nnet          7.3-20     2025-01-01 [4] CRAN (R 4.4.2)
 numDeriv    * 2016.8-1.1 2019-06-06 [1] CRAN (R 4.5.0)
 patchwork   * 1.3.0      2024-09-16 [1] CRAN (R 4.5.0)
 pillar        1.10.2     2025-04-05 [1] CRAN (R 4.5.0)
 pkgconfig     2.0.3      2019-09-22 [1] CRAN (R 4.5.0)
 purrr       * 1.0.4      2025-02-05 [1] CRAN (R 4.5.0)
 qpdf          1.3.5      2025-03-22 [1] CRAN (R 4.5.0)
 R6            2.6.1      2025-02-15 [1] CRAN (R 4.5.0)
 rbibutils     2.3        2024-10-04 [1] CRAN (R 4.5.0)
 Rcpp          1.0.14     2025-01-12 [1] CRAN (R 4.5.0)
 Rdpack        2.6.4      2025-04-09 [1] CRAN (R 4.5.0)
 readr       * 2.1.5      2024-01-10 [1] CRAN (R 4.5.0)
 reformulas    0.4.0      2024-11-03 [1] CRAN (R 4.5.0)
 rlang         1.1.6      2025-04-11 [1] CRAN (R 4.5.0)
 rmarkdown     2.29       2024-11-04 [1] CRAN (R 4.5.0)
 rpart       * 4.1.24     2025-01-07 [1] CRAN (R 4.5.0)
 rstudioapi    0.17.1     2024-10-22 [1] CRAN (R 4.5.0)
 scales        1.3.0      2023-11-28 [1] CRAN (R 4.5.0)
 sessioninfo   1.2.3      2025-02-05 [1] CRAN (R 4.5.0)
 someMTP       1.4.1.1    2021-03-01 [1] CRAN (R 4.5.0)
 stringi       1.8.7      2025-03-27 [1] CRAN (R 4.5.0)
 stringr     * 1.5.1      2023-11-14 [1] CRAN (R 4.5.0)
 survey        4.4-2      2024-03-20 [1] CRAN (R 4.5.0)
 survival      3.8-3      2024-12-17 [4] CRAN (R 4.4.2)
 tibble      * 3.2.1      2023-03-20 [1] CRAN (R 4.5.0)
 tidyr       * 1.3.1      2024-01-24 [1] CRAN (R 4.5.0)
 tidyselect    1.2.1      2024-03-11 [1] CRAN (R 4.5.0)
 tidyverse   * 2.0.0      2023-02-22 [1] CRAN (R 4.5.0)
 timechange    0.3.0      2024-01-18 [1] CRAN (R 4.5.0)
 tzdb          0.5.0      2025-03-15 [1] CRAN (R 4.5.0)
 utf8          1.2.4      2023-10-22 [1] CRAN (R 4.5.0)
 vctrs         0.6.5      2023-12-01 [1] CRAN (R 4.5.0)
 withr         3.0.2      2024-10-28 [1] CRAN (R 4.5.0)
 xfun          0.52       2025-04-02 [1] CRAN (R 4.5.0)
 yaml          2.3.10     2024-07-26 [1] CRAN (R 4.5.0)
