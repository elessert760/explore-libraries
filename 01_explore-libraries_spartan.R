#' ---
#' output: github_document
#' ---


#' Which libraries does R search for packages?



#' Installed packages

## use installed.packages() to get all installed packages

## how many packages?
library(devtools)
library(magrittr)
library(tidyverse)
library(pander)

installed.packages() %>% as_tibble() %>% select(Package) %>% unique %>% nrow()
# installed.packages()
#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

installed.packages() %>% 
  as_tibble() %>% 
  count(Priority, LibPath) %>% 
  arrange(desc(n)) %>% 
  pander()
##   * what proportion need compilation?

installed.packages() %>% 
  as_tibble() %>% 
  count(NeedsCompilation) %>% 
  ungroup() %>% 
  mutate(Prop = n/sum(n)*100) %>% 
  pander()

##   * how break down re: version of R they were built on

installed.packages() %>% 
  as_tibble() %>% 
  count(Version) %>% 
  filter(n>2) %>% 
  arrange(desc(n)) %>% 
  pander()


#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


# .Library
# .libPaths()

# ############################
# Looks like the .Library is the last in the .libpaths() list - because of install order?
# ############################

#' Going further

## if you have time to do more ...
## is every package in .Library either base or recommended?
installed <- installed.packages() %>% as_tibble()

installed[1:15,1:5] %>% pander()


all(list.files("/usr/lib/R/library") %in% installed$Package)

not_there <- which(!list.files("/usr/lib/R/library") %in% installed$Package)

list.files("/usr/lib/R/library")[not_there]

## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

installed.packages(fields = c("URL")) %>% 
  as_tibble() %>% 
  mutate(github = grepl("github", URL)) %>% 
  count(github) %>% 
  mutate(Prop = n/sum(n))

devtools::session_info()
