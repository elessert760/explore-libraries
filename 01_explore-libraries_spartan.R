#' Which libraries does R search for packages?


#' Installed packages

## use installed.packages() to get all installed packages

## how many packages?
library(magrittr)
library(tidyverse)
installed.packages() %>% as_data_frame() %>% select(Package) %>% unique %>% nrow()
# installed.packages()
#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

installed.packages() %>% 
  as_data_frame() %>% 
  group_by(Priority, LibPath) %>%
  count() %>% 
  arrange(desc(n))
##   * what proportion need compilation?

installed.packages() %>% 
  as_data_frame() %>% 
  group_by(NeedsCompilation) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(Prop = n/sum(n)*100)

##   * how break down re: version of R they were built on

installed.packages() %>% 
  as_data_frame() %>% 
  group_by(Version) %>% 
  count() %>% 
  arrange(desc(n))


#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
.Library
.libPaths()

# ############################
# Looks like the .Library is the last in the .libpaths() list - because of install order?
# ############################

#' Going further

## if you have time to do more ...
## is every package in .Library either base or recommended?
installed <- installed.packages() %>% as_data_frame()

all(list.files("/usr/lib/R/library") %in% installed$Package)

which(!list.files("/usr/lib/R/library") %in% installed$Package)

list.files("/usr/lib/R/library")[29]

## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

installed.packages(fields = c("URL")) %>% 
  as_data_frame() %>% 
  mutate(github = grepl("github", URL)) %>% 
  count(github) %>% 
  mutate(Prop = n/sum(n))

