01\_explore-libraries\_spartan.R
================
eric
Wed Jan 31 14:04:33 2018

Which libraries does R search for packages? Installed packages

``` r
## use installed.packages() to get all installed packages

## how many packages?
library(magrittr)
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
installed.packages() %>% as_data_frame() %>% select(Package) %>% unique %>% nrow()
```

    ## [1] 284

``` r
# installed.packages()
```

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

installed.packages() %>% 
  as_data_frame() %>% 
  group_by(Priority, LibPath) %>%
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 5 x 3
    ## # Groups:   Priority, LibPath [5]
    ##      Priority                                      LibPath     n
    ##         <chr>                                        <chr> <int>
    ## 1        <NA> /home/eric/R/x86_64-pc-linux-gnu-library/3.4   225
    ## 2        <NA>                /usr/local/lib/R/site-library   151
    ## 3 recommended                           /usr/lib/R/library    15
    ## 4        base                           /usr/lib/R/library    14
    ## 5        <NA>                      /usr/lib/R/site-library     2

``` r
##   * what proportion need compilation?

installed.packages() %>% 
  as_data_frame() %>% 
  group_by(NeedsCompilation) %>% 
  count() %>% 
  ungroup() %>% 
  mutate(Prop = n/sum(n)*100)
```

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n   Prop
    ##              <chr> <int>  <dbl>
    ## 1               no   205 50.369
    ## 2              yes   187 45.946
    ## 3             <NA>    15  3.686

``` r
##   * how break down re: version of R they were built on

installed.packages() %>% 
  as_data_frame() %>% 
  group_by(Version) %>% 
  count() %>% 
  arrange(desc(n))
```

    ## # A tibble: 188 x 2
    ## # Groups:   Version [188]
    ##    Version     n
    ##      <chr> <int>
    ##  1   1.1.0    15
    ##  2   3.4.3    14
    ##  3   0.8.0    10
    ##  4   0.2.0     9
    ##  5   1.0.0     9
    ##  6     0.3     8
    ##  7   1.1.1     8
    ##  8   0.1.1     7
    ##  9     1.5     6
    ## 10   0.1.2     5
    ## # ... with 178 more rows

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
.Library
```

    ## [1] "/usr/lib/R/library"

``` r
.libPaths()
```

    ## [1] "/home/eric/R/x86_64-pc-linux-gnu-library/3.4"
    ## [2] "/usr/local/lib/R/site-library"               
    ## [3] "/usr/lib/R/site-library"                     
    ## [4] "/usr/lib/R/library"

``` r
# ############################
# Looks like the .Library is the last in the .libpaths() list - because of install order?
# ############################
```

Going further

``` r
## if you have time to do more ...
## is every package in .Library either base or recommended?
installed <- installed.packages() %>% as_data_frame()

all(list.files("/usr/lib/R/library") %in% installed$Package)
```

    ## [1] FALSE

``` r
which(!list.files("/usr/lib/R/library") %in% installed$Package)
```

    ## [1] 29

``` r
list.files("/usr/lib/R/library")[29]
```

    ## [1] "translations"

``` r
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

installed.packages(fields = c("URL")) %>% 
  as_data_frame() %>% 
  mutate(github = grepl("github", URL)) %>% 
  count(github) %>% 
  mutate(Prop = n/sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n   Prop
    ##    <lgl> <int>  <dbl>
    ## 1  FALSE   194 0.4767
    ## 2   TRUE   213 0.5233
