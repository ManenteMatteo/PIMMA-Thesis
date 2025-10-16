## ----setup, include=FALSE----------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
library(readxl)
library(metafor)
library(plyr)
library(ggpubr)
library(grid)
library(gridExtra)
library(puniform)
library(metapsyTools)
set.seed(1234)

# helper functions
checkVariable <- function(data, variable) {
  data  %>% pull({{variable}}) %>% table(useNA = "always")
}


## ----------------------------------------------------------------------------------------------
data_2022_raw <- read_excel("data/raw/data-depression-psyctr-2022.xlsx")


## ----------------------------------------------------------------------------------------------
data_2022 <- data_2022_raw %>%
  mutate(vi = .g_se^2,
         yi = .g,
         es_id = row_number()) %>% # each effect size gets unique ID
  filter(!is.na(yi)) %>%
  group_by(study) %>%
  mutate(study_id = group_indices()) %>%
  select(study_id, es_id, study, yi, vi, sei = .g_se, everything()) %>%
  ungroup()


## ----------------------------------------------------------------------------------------------
data_2022 %>% checkVariable(target_group)

data_2022_target_group <- data_2022 %>%
  mutate(target_group = case_when(
    target_group == "4 & 5" & study == "Zhao, 2019" ~ "perinatal depression", # Zhao, 2019 is both general medical and perinatal depression, I recoded it as perinatal depression as this was the main focus of the study.
    TRUE ~ target_group)) %>%
  mutate(
    target_group = recode(target_group, "adul"     = "adults"),
    target_group = recode(target_group, "yadul"     = "adults"),
    target_group = recode(target_group, "old"     = "older adults"),
    target_group = recode(target_group, "stud"     = "student population"),
    target_group = recode(target_group, "ppd"     = "perinatal depression"),
    target_group = recode(target_group, "med"     = "general medical"),
    target_group = recode(target_group, "oth"     = "other target groups"))

data_2022_target_group %>% checkVariable(target_group)


## ----------------------------------------------------------------------------------------------
target_group <- c(unique(data_2022_target_group$target_group), "all groups")

target_group


## ----eval = FALSE------------------------------------------------------------------------------
# if(specifications$target_group[i] == "adults") {
#   dat <- dat[dat$target_group == "adults", ]
# } else {
#   if(specifications$target_group[i] == "general medical") {
#     dat <- dat[dat$target_group == "general medical", ]
#   } else {
#     if(specifications$target_group[i] == "perinatal depression") {
#       dat <- dat[dat$target_group == "perinatal depression", ]
#     } else {
#       if(specifications$target_group[i] == "older adults") {
#         dat <- dat[dat$target_group == "older adults", ]
#       } else {
#         if(specifications$target_group[i] == "other target groups") {
#           dat <- dat[dat$target_group == "other target groups", ]
#         } else {
#           if(specifications$target_group[i] == "student population") {
#             dat <- dat[dat$target_group == "student population", ]
#           }
#         }
#       }
#     }
#   }
# }


## ----eval = FALSE------------------------------------------------------------------------------
# "Group: Adults",
# "Group: General medical",
# "Group: Perinatal depression",
# "Group: Student population",
# "Group: Older adults",
# "Group: Other groups",
# "Group: All groups",


## ----------------------------------------------------------------------------------------------
data_2022_target_group %>% checkVariable(format)

data_2022_format <- data_2022_target_group %>%
    mutate(format = recode(format, "ind" = "individual"),
           format = recode(format, "grp" = "group"),
           format = recode(format, "gsh" = "guided self-help"),
           format = recode(format, "ush" = "other formats"),
           format = recode(format, "tel" = "other formats"),
           format = recode(format, "oth" = "other formats"),
           format = recode(format, "cpl" = "other formats"))

data_2022_format %>% checkVariable(format)


## ----------------------------------------------------------------------------------------------
format <- c(unique(data_2022_format$format), "all formats")

format


## ----eval = FALSE------------------------------------------------------------------------------
# if(specifications$format[i] == "group") {
#   dat <- dat[dat$format == "group", ]
# } else {
#   if(specifications$format[i] == "individual") {
#     dat <- dat[dat$format == "individual", ]
#   } else {
#     if(specifications$format[i] == "guided self-help") {
#       dat <- dat[dat$format == "guided self-help", ]
#     } else {
#       if(specifications$format[i] == "other formats") {
#         dat <- dat[dat$format == "other formats", ]
#       }
#     }
#   }
# }


## ----eval = FALSE------------------------------------------------------------------------------
# "Format: Group",
# "Format: Individual",
# "Format: Guided self-help",
# "Format: Other",
# "Format: All",


## ----------------------------------------------------------------------------------------------
data_2022_diagnosis <- data_2022_format

table(data_2022_diagnosis$diagnosis)


## ----------------------------------------------------------------------------------------------
data_2022_format %>% checkVariable(diagnosis)

data_2022_diagnosis <- data_2022_format %>%
  mutate(diagnosis = recode(diagnosis, "mdd" = "diagnosis"),
         diagnosis = recode(diagnosis, "mood" = "diagnosis"),
         diagnosis = recode(diagnosis, "cut" = "cut-off score"),
         diagnosis = recode(diagnosis, "sub" = "subclinical depression"),
         diagnosis = recode(diagnosis, "chr" = "diagnosis"))

data_2022_diagnosis %>% checkVariable(diagnosis)


## ----------------------------------------------------------------------------------------------
diagnosis<- c(unique(data_2022_diagnosis$diagnosis), "all diagnoses")

diagnosis


## ----eval = FALSE------------------------------------------------------------------------------
#     if(specifications$diagnosis[i] == "diagnosis") {
#     dat <- dat[dat$diagnosis== "diagnosis", ]
#   } else {
#     if(specifications$diagnosis[i] == "cut-off score") {
#       dat <- dat[dat$diagnosis== "cut-off score", ]
#     } else {
#     if(specifications$diagnosis[i] == "subclinical depression") {
#       dat <- dat[dat$diagnosis== "subclinical depression", ]
#     }
#     }
#   }


## ----eval = FALSE------------------------------------------------------------------------------
# "Diagnoses: Diagnoses",
# "Diagnoses: Cut-off score",
# "Diagnoses: Subclinical Depressen",
# "Diagnoses: All diagnoses",


## ----------------------------------------------------------------------------------------------
data_2022_diagnosis %>% checkVariable(condition_arm1)

data_2022_type <- data_2022_diagnosis %>%
  mutate( type = condition_arm1,
          type = recode(type, "cbt"   = "cbt-based"),
          type = recode(type, "pst"   = "cbt-based"),
          type = recode(type, "3rd"   = "cbt-based"),
          type = recode(type, "bat"   = "cbt-based"),
          type = recode(type, "dyn"   = "not-cbt-based"),
          type = recode(type, "ipt"   = "not-cbt-based"),
          type = recode(type, "lrt"   = "not-cbt-based"),
          type = recode(type, "sup"   = "not-cbt-based"),
          type = recode(type, "other psy" = "not-cbt-based"))

data_2022_type %>% checkVariable(type)


## ----------------------------------------------------------------------------------------------
type <- c(unique(data_2022_type$type), "all types")
type


## ----eval = FALSE------------------------------------------------------------------------------
#     if(specifications$type[i] == "cbt-based") {
#     dat <- dat[dat$type == "cbt-based", ]
#   } else {
#     if(specifications$type[i] == "not-cbt-based") {
#       dat <- dat[dat$type == "not-cbt-based", ]
#     }
#   }


## ----eval = FALSE------------------------------------------------------------------------------
# "Type: CBT-based",
# "Type: Not-CBT-based",
# "Type: All interventions",


## ----------------------------------------------------------------------------------------------
data_2022_type %>% checkVariable(condition_arm2)
data_2022_control <- data_2022_type %>%
  mutate(control = condition_arm2)
table(data_2022_control$control)


## ----------------------------------------------------------------------------------------------
control <- c(unique(data_2022_control$control), "all control conditions")

control


## ----eval = FALSE------------------------------------------------------------------------------
#   if(specifications$control[i] == "wl") {
#     dat <- dat[dat$control == "wl", ]
#   } else {
#     if(specifications$control[i] == "cau") {
#       dat <- dat[dat$control == "cau", ]
#     } else {
#       if(specifications$control[i] == "other ctr") {
#         dat <- dat[dat$control == "other ctr", ]
#       }
#     }
#   }


## ----eval = FALSE------------------------------------------------------------------------------
# "Control: Care as usual",
# "Control: Waitlist",
# "Control: Other",
# "Control: All",


## ----------------------------------------------------------------------------------------------
data_2022_control %>% checkVariable(country)
data_2022_country <- data_2022_control %>%
  mutate(region = case_when(
    country == "can" ~ "North America",
    country == "uk" ~ "Europe",
    country == "eu" ~ "Europe",
    country == "us" ~ "North America",
    country == "au" ~ "Australia",
    country == "eas" ~ "East Asia",
    country == "oth" ~ "Other Region"))

table(data_2022_country$region)


## ----------------------------------------------------------------------------------------------
region <- str_to_lower(c(unique(data_2022_country$region), "All Regions"))

region


## ----eval = FALSE------------------------------------------------------------------------------
#     if(specifications$region[i] == "europe") {
#     dat <- dat[dat$region == "europe", ]
#   } else {
#     if(specifications$region[i] == "other region") {
#       dat <- dat[dat$region == "other region", ]
#     } else {
#       if(specifications$region[i] == "north america") {
#         dat <- dat[dat$region == "north america", ]
#       } else {
#       if(specifications$region[i] == "east asia") {
#         dat <- dat[dat$region == "east asia", ]
#       } else {
#       if(specifications$region[i] == "australia") {
#         dat <- dat[dat$region == "australia", ]
#       }
#     }
#       }
#     }


## ----eval = FALSE------------------------------------------------------------------------------
# "Region: Europe",
# "Region: North America",
# "Region: East Asia",
# "Region: Australia",
# "Region: Other",
# "Region: All",


## ----------------------------------------------------------------------------------------------
data_2022_country %>% checkVariable(rob)
data_2022_rob <- data_2022_country %>%
  mutate(risk_of_bias = recode(rob,
                               "4" = "Low",
                               "0" = "High",
                               "1" = "Some Concern",
                               "2" = "Some Concern",
                               "3" = "Some Concern"))

table(data_2022_rob$risk_of_bias)


## ----------------------------------------------------------------------------------------------
risk_of_bias <- str_to_lower(c(unique(data_2022_rob$risk_of_bias), "All risk of biases"))
risk_of_bias


## ----eval = FALSE------------------------------------------------------------------------------
#   if(specifications$risk_of_bias[i] == "low") {
#     dat <- dat[dat$risk_of_bias == "low", ]
#   } else {
#     if(specifications$risk_of_bias[i] == "some concern") {
#       dat <- dat[dat$risk_of_bias == "some concern", ]
#   } else {
#     if(specifications$risk_of_bias[i] == "high") {
#       dat <- dat[dat$risk_of_bias == "high", ]
#     }
#   }


## "Risk of Bias: Low",
## "Risk of Bias: Some Concern",
## "Risk of Bias: High",
## "Risk of Bias: All",

## ----------------------------------------------------------------------------------------------
ma_3lvl <- data_2022_rob %>%
  rma.mv(data = .,
         yi = yi,
         V = vi,
         method = "REML",
         control=list(optimizer = "optim", optmethod="Nelder-Mead"),
         random = list(~1 | es_id,
                       ~1 | study_id),
         sparse=TRUE)

prediction_interval_lb <- predict(ma_3lvl)$pi.lb
prediction_interval_ub <- predict(ma_3lvl)$pi.ub

ci_lower <- ma_3lvl$yi - 1.96*sqrt(ma_3lvl$vi)
ci_upper <-  ma_3lvl$yi + 1.96*sqrt(ma_3lvl$vi)

data_2022_outlier <- data_2022_rob %>%
  cbind(ci_lower, ci_upper) %>%
  relocate(study, yi, ci_lower, ci_upper) %>%
  mutate(outlier = case_when(
    ci_lower > prediction_interval_ub |ci_upper < prediction_interval_lb ~ "ci outside pi",
    TRUE ~ "no outlier"
      ),
    outlier) %>%
    relocate(id_study, yi,outlier, ci_lower, ci_upper)


## ----------------------------------------------------------------------------------------------
outlier <- str_to_lower(c(unique(data_2022_outlier$outlier), "All studies"))
outlier


## ----eval = FALSE------------------------------------------------------------------------------
#   if(specifications$outlier[i] == "no outlier") {
#     dat <- dat[dat$outlier == "no outlier", ]
#   } else {
#     if(specifications$outlier[i] == "ci outside pi") {
#       dat <- dat[dat$outlier == "ci outside pi", ]
#     }
#   }


## ----------------------------------------------------------------------------------------------
data_2022_outlier <- data_2022_outlier %>%
  mutate(outlier_1.5_sd = ifelse(yi > 1.5, "outlier > 1.5 sd", "no outlier"))


## ----------------------------------------------------------------------------------------------
data_2022_multiple_outcome_types <- filterPriorityRule(data_2022_outlier,
                                                       outcome_type = c("msd", "response", "remission", "other dich", "change", "other statistic"),
                                                       .study.indicator = "study")


## ----------------------------------------------------------------------------------------------
data_2022_one_outcome <- data_2022_outlier %>%
    filter(.id %in% data_2022_multiple_outcome_types$.id) %>%
    mutate(multiple_outcome_types = "select one outcome type")

data_2022_multiple_outcomes <- data_2022_outlier %>%
  filter(!.id %in% data_2022_multiple_outcome_types$.id) %>%
  mutate(multiple_outcome_types = "select all outcome types") %>%
  relocate(id_study, multiple_outcome_types, outcome_type)

data_2022_multiple_outcome_types_joined <- bind_rows(data_2022_one_outcome, data_2022_multiple_outcomes )  %>%
  arrange(id_study) %>%
  relocate(id_study, multiple_outcome_types, outcome_type)

table(data_2022_multiple_outcome_types_joined$multiple_outcome_types)


## ----eval = FALSE------------------------------------------------------------------------------
#   if(specifications$multiple_outcome_types[i] == "select one outcome type") {
#     dat <- dat[dat$multiple_outcome_types == "select all outcome types", ]
#   }


## ----------------------------------------------------------------------------------------------
multiple_outcome_types <- str_to_lower(c(unique(data_2022_multiple_outcome_types_joined$multiple_outcome_types), "All outcomes"))
multiple_outcome_types


## ----define-how-factors------------------------------------------------------------------------
ma_method <- c("3-level", "rve", "reml", "fe", "pet-peese", "p-uniform")


## ----------------------------------------------------------------------------------------------
# P
length(target_group) *
# I
  length(type) * length(format) *
# C
  length(control) *
# O
  length(diagnosis) *
# S
  length(risk_of_bias) * length(ma_method)  * length(outlier) #* length(multiple_outcome_types)


## ----------------------------------------------------------------------------------------------
data <- mutate_all(data_2022_rob,
                   funs(str_to_lower)) %>%
  mutate(n_1 = as.numeric(ifelse(is.na(n_arm1), totaln_arm1, n_arm1)),
         n_2 = as.numeric(ifelse(is.na(n_arm2), totaln_arm1, n_arm2)),
         sample_size = n_1 + n_2,
         es_id = row_number() ,
         rob_include_best = ifelse(risk_of_bias == "low", 1, 0),
         rob_exclude_worst = ifelse(risk_of_bias %in% c("low", "some concern"), 1, 0)) %>%
  select(study,
         es_id,
         yi, vi, sei,
         target_group,
         format,
         diagnosis,
         type,
         control,
         region,
         risk_of_bias,
         rob,
         rob_include_best,
         rob_exclude_worst,
         n_1,
         n_2,
         sample_size)

data$vi <- as.numeric(data$vi)
data$yi <- as.numeric(data$yi)
data$sei <- as.numeric(data$sei)

data


## ----------------------------------------------------------------------------------------------
data <- data %>%
  mutate_if(names(.) %in% c("target_group","diagnosis","format", "type", "rob", "control", "condition_arm1", "condition_arm2", "outcome_type", "rating" ), funs(as.factor(.)))

summary(data)


## ----------------------------------------------------------------------------------------------
sample_size_data <- data %>%
  group_by(study) %>%
  distinct(sample_size) %>%
  plyr::summarise(sample_size_sum = sum(sample_size, na.rm = T),
            sample_size_median = median(sample_size, na.rm = T),
            sample_size_mean = mean(sample_size, na.rm = T))

sample_size_data


## ----------------------------------------------------------------------------------------------
data %>%
  group_by(study) %>%
  distinct(sample_size) %>% print(n=701)


## ----------------------------------------------------------------------------------------------
unique_studies <- length(unique(data$study))
unique_studies


## ----------------------------------------------------------------------------------------------
data %>%
  dplyr::summarise(mean_g = mean(yi),
                   mean_vi = mean(vi),
                   range_min = range(yi)[1],
                   range_max = range(yi)[2],
                   quantile1 = quantile(yi)[1],
                   quantile2 = quantile(yi)[2],
                   quantile3 = quantile(yi)[3],
                   quantile4 = quantile(yi)[4],
                   quantile5 = quantile(yi)[5],
                   )


## ----------------------------------------------------------------------------------------------
ggplot(data, aes(x = yi, y = sample_size)) +
  geom_point(alpha = .4, shape = 1) +
  theme_classic()


## ----------------------------------------------------------------------------------------------
data %>%
  filter(yi > 2) %>%
  arrange(desc(yi))


## ----------------------------------------------------------------------------------------------
colnames(data)


## ----------------------------------------------------------------------------------------------
table(data$target_group)
target_group


## ----------------------------------------------------------------------------------------------
table(data$region)
region


## ----------------------------------------------------------------------------------------------
table(data$diagnosis)
diag


## ----------------------------------------------------------------------------------------------
table(data$type)
type


## ----------------------------------------------------------------------------------------------
table(data$format)
format


## ----------------------------------------------------------------------------------------------
table(data$control)
control


## ----------------------------------------------------------------------------------------------
table(data$risk_of_bias)
risk_of_bias


## ----------------------------------------------------------------------------------------------
data_one_outcome_type <- mutate_all(data_2022_multiple_outcome_types_joined,
                   funs(str_to_lower)) %>%
  mutate(n_1 = as.numeric(ifelse(is.na(n_arm1), totaln_arm1, n_arm1)),
         n_2 = as.numeric(ifelse(is.na(n_arm2), totaln_arm1, n_arm2)),
         sample_size = n_1 + n_2,
         es_id = row_number() ,
         rob_include_best = ifelse(risk_of_bias == "low", 1, 0),
         rob_exclude_worst = ifelse(risk_of_bias %in% c("low", "some concern"), 1, 0)) %>%
  select(study,
         es_id,
         yi, vi, sei,
         target_group,
         format,
         diagnosis,
         type,
         control,
         region,
         risk_of_bias,
         rob,
         multiple_outcome_types,
         outlier,
         outlier_1.5_sd,
         rob_include_best,
         rob_exclude_worst,
         n_1,
         n_2,
         sample_size)

data_one_outcome_type$vi <- as.numeric(data_one_outcome_type$vi)
data_one_outcome_type$yi <- as.numeric(data_one_outcome_type$yi)
data_one_outcome_type$sei <- as.numeric(data_one_outcome_type$sei)


data_one_outcome_type


## ----------------------------------------------------------------------------------------------
data_one_outcome_type <- data_one_outcome_type %>% filter(multiple_outcome_types == "select one outcome type")


## ----------------------------------------------------------------------------------------------
data_one_outcome_type %>% relocate(study, sample_size)


## ----------------------------------------------------------------------------------------------
data_one_outcome_type %>%
  #group_by(study) %>%
  #distinct(sample_size) %>%
  plyr::summarise(sample_size_sum = sum(sample_size, na.rm = T),
                  sample_size_median = median(sample_size, na.rm = T),
                  sample_size_mean = mean(sample_size, na.rm = T))


## ----------------------------------------------------------------------------------------------
sample_size_data <- data_one_outcome_type %>%
  group_by(study) %>%
  distinct(sample_size) %>%
  plyr::summarise(sample_size_sum = sum(sample_size, na.rm = T),
            sample_size_median = median(sample_size, na.rm = T),
            sample_size_mean = mean(sample_size, na.rm = T))

sample_size_data


## ----------------------------------------------------------------------------------------------
unique_studies <- length(unique(data_one_outcome_type$study))
unique_studies


## ----------------------------------------------------------------------------------------------
data_one_outcome_type %>%
  dplyr::summarise(mean_g = mean(yi),
                   mean_vi = mean(vi),
                   range_min = range(yi)[1],
                   range_max = range(yi)[2],
                   quantile1 = quantile(yi)[1],
                   quantile2 = quantile(yi)[2],
                   quantile3 = quantile(yi)[3],
                   quantile4 = quantile(yi)[4],
                   quantile5 = quantile(yi)[5],
                   )


## ----------------------------------------------------------------------------------------------
ggplot(data_one_outcome_type, aes(x = yi, y = sample_size)) +
  geom_point(alpha = .4, shape = 1) +
  theme_classic()


## ----------------------------------------------------------------------------------------------
data_one_outcome_type %>%
  filter(yi > 2) %>%
  arrange(desc(yi))


## ----------------------------------------------------------------------------------------------
#write_csv(data, "data/tidy/data_cleaned_one_outcome_type.csv")
#write_csv(data, "data/tidy/data_cleaned.csv")

## FILIPPO
# here I simply save the data_cleaned_one_outcome_type.csv

saveRDS(data_one_outcome_type, "data/clean/data_cleaned_one_outcome_type.rds")


