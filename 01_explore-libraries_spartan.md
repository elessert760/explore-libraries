01\_explore-libraries\_spartan.R
================
eric
Wed Jan 31 15:58:36 2018

Which libraries does R search for packages? Installed packages

``` r
## use installed.packages() to get all installed packages

## how many packages?
library(devtools)
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
library(pander)

installed.packages() %>% as_tibble() %>% select(Package) %>% unique %>% nrow()
```

    ## [1] 285

``` r
# installed.packages()
```

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

installed.packages() %>% 
  as_tibble() %>% 
  count(Priority, LibPath) %>% 
  arrange(desc(n)) %>% 
  pander()
```

<table style="width:92%;">
<colgroup>
<col width="19%" />
<col width="65%" />
<col width="6%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Priority</th>
<th align="center">LibPath</th>
<th align="center">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">NA</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">226</td>
</tr>
<tr class="even">
<td align="center">NA</td>
<td align="center">/usr/local/lib/R/site-library</td>
<td align="center">151</td>
</tr>
<tr class="odd">
<td align="center">recommended</td>
<td align="center">/usr/lib/R/library</td>
<td align="center">15</td>
</tr>
<tr class="even">
<td align="center">base</td>
<td align="center">/usr/lib/R/library</td>
<td align="center">14</td>
</tr>
<tr class="odd">
<td align="center">NA</td>
<td align="center">/usr/lib/R/site-library</td>
<td align="center">2</td>
</tr>
</tbody>
</table>

``` r
##   * what proportion need compilation?

installed.packages() %>% 
  as_tibble() %>% 
  count(NeedsCompilation) %>% 
  ungroup() %>% 
  mutate(Prop = n/sum(n)*100) %>% 
  pander()
```

<table style="width:44%;">
<colgroup>
<col width="26%" />
<col width="8%" />
<col width="9%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">NeedsCompilation</th>
<th align="center">n</th>
<th align="center">Prop</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">no</td>
<td align="center">205</td>
<td align="center">50.25</td>
</tr>
<tr class="even">
<td align="center">yes</td>
<td align="center">188</td>
<td align="center">46.08</td>
</tr>
<tr class="odd">
<td align="center">NA</td>
<td align="center">15</td>
<td align="center">3.676</td>
</tr>
</tbody>
</table>

``` r
##   * how break down re: version of R they were built on

installed.packages() %>% 
  as_tibble() %>% 
  count(Version) %>% 
  filter(n>2) %>% 
  arrange(desc(n)) %>% 
  pander()
```

<table style="width:19%;">
<colgroup>
<col width="13%" />
<col width="5%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Version</th>
<th align="center">n</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">1.1.0</td>
<td align="center">15</td>
</tr>
<tr class="even">
<td align="center">3.4.3</td>
<td align="center">14</td>
</tr>
<tr class="odd">
<td align="center">0.8.0</td>
<td align="center">10</td>
</tr>
<tr class="even">
<td align="center">0.2.0</td>
<td align="center">9</td>
</tr>
<tr class="odd">
<td align="center">1.0.0</td>
<td align="center">9</td>
</tr>
<tr class="even">
<td align="center">0.3</td>
<td align="center">8</td>
</tr>
<tr class="odd">
<td align="center">1.1.1</td>
<td align="center">8</td>
</tr>
<tr class="even">
<td align="center">0.1.1</td>
<td align="center">7</td>
</tr>
<tr class="odd">
<td align="center">1.5</td>
<td align="center">6</td>
</tr>
<tr class="even">
<td align="center">0.1.2</td>
<td align="center">5</td>
</tr>
<tr class="odd">
<td align="center">0.1.5</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">0.2</td>
<td align="center">5</td>
</tr>
<tr class="odd">
<td align="center">1.0-6</td>
<td align="center">5</td>
</tr>
<tr class="even">
<td align="center">2.2.1</td>
<td align="center">5</td>
</tr>
<tr class="odd">
<td align="center">0.1</td>
<td align="center">4</td>
</tr>
<tr class="even">
<td align="center">0.1.0</td>
<td align="center">4</td>
</tr>
<tr class="odd">
<td align="center">0.4.0</td>
<td align="center">4</td>
</tr>
<tr class="even">
<td align="center">0.4-7</td>
<td align="center">4</td>
</tr>
<tr class="odd">
<td align="center">0.7.0</td>
<td align="center">4</td>
</tr>
<tr class="even">
<td align="center">0.9.1</td>
<td align="center">4</td>
</tr>
<tr class="odd">
<td align="center">1.2.4</td>
<td align="center">4</td>
</tr>
<tr class="even">
<td align="center">2.0.1</td>
<td align="center">4</td>
</tr>
<tr class="odd">
<td align="center">0.1.4</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">0.4.1</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">0.4.2</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">0.4.3</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">0.6.1</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">0.7</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">0.7.2</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">1.0.1</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">1.0.4</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">1.2</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">1.2.0</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">1.3.4</td>
<td align="center">3</td>
</tr>
<tr class="odd">
<td align="center">1.5-5</td>
<td align="center">3</td>
</tr>
<tr class="even">
<td align="center">1.6</td>
<td align="center">3</td>
</tr>
</tbody>
</table>

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


# .Library
# .libPaths()

# ############################
# Looks like the .Library is the last in the .libpaths() list - because of install order?
# ############################
```

Going further

``` r
## if you have time to do more ...
## is every package in .Library either base or recommended?
installed <- installed.packages() %>% as_tibble()

installed[1:15,1:4] %>% pander()
```

<table>
<colgroup>
<col width="15%" />
<col width="57%" />
<col width="13%" />
<col width="13%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">Package</th>
<th align="center">LibPath</th>
<th align="center">Version</th>
<th align="center">Priority</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">AlgDesign</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.1-7.3</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">anytime</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">0.3.0</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">backports</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.1.0</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">BH</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.62.0-1</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">bit</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.1-12</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">bit64</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">0.9-7</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">blob</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.1.0</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">brew</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.0-6</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">broom</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">0.4.2</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">car</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">2.1-5</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">cellranger</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.1.0</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">chron</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">2.3-51</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">cli</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.0.0</td>
<td align="center">NA</td>
</tr>
<tr class="even">
<td align="center">clipr</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">0.4.0</td>
<td align="center">NA</td>
</tr>
<tr class="odd">
<td align="center">clisymbols</td>
<td align="center">/home/eric/R/x86_64-pc-linux-gnu-library/3.4</td>
<td align="center">1.2.0</td>
<td align="center">NA</td>
</tr>
</tbody>
</table>

``` r
all(list.files("/usr/lib/R/library") %in% installed$Package)
```

    ## [1] FALSE

``` r
not_there <- which(!list.files("/usr/lib/R/library") %in% installed$Package)

list.files("/usr/lib/R/library")[not_there]
```

    ## [1] "translations"

``` r
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!

installed.packages(fields = c("URL")) %>% 
  as_tibble() %>% 
  mutate(github = grepl("github", URL)) %>% 
  count(github) %>% 
  mutate(Prop = n/sum(n)) %>% 
  pander()
```

<table style="width:32%;">
<colgroup>
<col width="12%" />
<col width="8%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th align="center">github</th>
<th align="center">n</th>
<th align="center">Prop</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="center">FALSE</td>
<td align="center">194</td>
<td align="center">0.4755</td>
</tr>
<tr class="even">
<td align="center">TRUE</td>
<td align="center">214</td>
<td align="center">0.5245</td>
</tr>
</tbody>
</table>

``` r
devtools::session_info() %>% map(pander)
```

    ## Warning in pander.default(.x[[i]], ...): No pander.method for
    ## "platform_info", reverting to default.

    ## $platform
    ## [1] "\n\n  * **version**: R version 3.4.3 (2017-11-30)\n  * **system**: x86_64, linux-gnu\n  * **ui**: X11\n  * **language**: en_US\n  * **collate**: en_US.UTF-8\n  * **tz**: US/Pacific\n  * **date**: 2018-01-31\n\n<!-- end of list -->\n\n\n"
    ## attr(,"class")
    ## [1] "knit_asis"
    ## attr(,"knit_cacheable")
    ## [1] NA
    ## 
    ## $packages
    ## [1] "\n---------------------------------------------------------------------\n  package     *    version        date               source          \n------------ --- ------------ ------------ --------------------------\n assertthat         0.2.0      2017-04-11        CRAN (R 3.4.1)      \n\n backports          1.1.0      2017-05-22        CRAN (R 3.4.1)      \n\n    base      *     3.4.3      2017-12-01            local           \n\n   bindr             0.1       2016-11-13        CRAN (R 3.4.1)      \n\n  bindrcpp    *      0.2       2017-06-17        CRAN (R 3.4.1)      \n\n   broom            0.4.2      2017-02-13        CRAN (R 3.4.0)      \n\n cellranger         1.1.0      2016-07-27        CRAN (R 3.4.0)      \n\n colorspace         1.3-2      2016-12-14        CRAN (R 3.4.0)      \n\n  compiler          3.4.3      2017-12-01            local           \n\n  datasets    *     3.4.3      2017-12-01            local           \n\n  devtools    *     1.13.3     2017-08-02        CRAN (R 3.4.1)      \n\n   digest           0.6.12     2017-01-27        cran (@0.6.12)      \n\n   dplyr      *     0.7.2      2017-07-20        CRAN (R 3.4.1)      \n\n  evaluate          0.10.1     2017-06-24        CRAN (R 3.4.1)      \n\n  forcats           0.2.0      2017-01-23        CRAN (R 3.4.0)      \n\n  foreign           0.8-69     2017-06-21        CRAN (R 3.4.0)      \n\n  ggplot2     *   2.2.1.9000   2017-05-02            Github          \n                                            (hadley/ggplot2@f4398b6) \n\n    glue            1.1.1      2017-06-21        CRAN (R 3.4.1)      \n\n  graphics    *     3.4.3      2017-12-01            local           \n\n grDevices    *     3.4.3      2017-12-01            local           \n\n    grid            3.4.3      2017-12-01            local           \n\n   gtable           0.2.0      2016-02-26        CRAN (R 3.4.0)      \n\n   haven            1.1.0      2017-07-09        CRAN (R 3.4.1)      \n\n    hms              0.3       2016-11-22        CRAN (R 3.4.0)      \n\n htmltools          0.3.6      2017-04-28        cran (@0.3.6)       \n\n    httr            1.3.1      2017-08-20        CRAN (R 3.4.2)      \n\n  jsonlite           1.5       2017-06-01        CRAN (R 3.4.1)      \n\n   knitr             1.17      2017-08-10        CRAN (R 3.4.1)      \n\n  lattice          0.20-35     2017-03-25        CRAN (R 3.3.3)      \n\n  lazyeval          0.2.0      2016-06-12        CRAN (R 3.3.2)      \n\n lubridate          1.6.0      2016-09-13        CRAN (R 3.4.0)      \n\n  magrittr    *      1.5       2014-11-22        CRAN (R 3.4.0)      \n\n  memoise           1.1.0      2017-04-21        CRAN (R 3.4.0)      \n\n  methods     *     3.4.3      2017-12-01            local           \n\n   mnormt           1.5-5      2016-10-15        CRAN (R 3.4.0)      \n\n   modelr           0.1.1      2017-07-24        CRAN (R 3.4.1)      \n\n  munsell           0.4.3      2016-02-13        CRAN (R 3.4.0)      \n\n    nlme           3.1-131     2017-02-06        CRAN (R 3.4.0)      \n\n   pander     *     0.6.1      2017-08-06        CRAN (R 3.4.3)      \n\n  parallel          3.4.3      2017-12-01            local           \n\n pkgconfig          2.0.1      2017-03-21        CRAN (R 3.4.1)      \n\n    plyr            1.8.4      2016-06-08        CRAN (R 3.4.0)      \n\n   psych            1.7.5      2017-05-03        CRAN (R 3.4.0)      \n\n   purrr      *     0.2.3      2017-08-02        CRAN (R 3.4.1)      \n\n     R6             2.2.2      2017-06-17        CRAN (R 3.4.1)      \n\n    Rcpp           0.12.12     2017-07-15        CRAN (R 3.4.1)      \n\n   readr      *     1.1.1      2017-05-16        CRAN (R 3.4.0)      \n\n   readxl           1.0.0      2017-04-18        CRAN (R 3.4.0)      \n\n  reshape2          1.4.2      2016-10-22        CRAN (R 3.4.0)      \n\n   rlang            0.1.2      2017-08-09        CRAN (R 3.4.1)      \n\n rmarkdown           1.6       2017-06-15        CRAN (R 3.4.1)      \n\n rprojroot           1.2       2017-01-16        CRAN (R 3.4.0)      \n\n   rvest            0.3.2      2016-06-17        CRAN (R 3.4.0)      \n\n   scales           0.4.1      2016-11-09        CRAN (R 3.4.0)      \n\n   stats      *     3.4.3      2017-12-01            local           \n\n  stringi           1.1.5      2017-04-07        CRAN (R 3.4.1)      \n\n  stringr           1.2.0      2017-02-18        CRAN (R 3.4.1)      \n\n   tibble     *     1.3.4      2017-08-22        CRAN (R 3.4.1)      \n\n   tidyr      *     0.7.0      2017-08-16        CRAN (R 3.4.1)      \n\n tidyverse    *     1.1.1      2017-01-27        CRAN (R 3.4.0)      \n\n   tools            3.4.3      2017-12-01            local           \n\n   utils      *     3.4.3      2017-12-01            local           \n\n   withr            2.0.0      2017-07-28        CRAN (R 3.4.1)      \n\n    xml2            1.1.1      2017-01-24        CRAN (R 3.4.0)      \n\n    yaml            2.1.14     2016-11-12        CRAN (R 3.4.1)      \n---------------------------------------------------------------------\n\n"
    ## attr(,"class")
    ## [1] "knit_asis"
    ## attr(,"knit_cacheable")
    ## [1] NA

``` r
# ¯\_(ツ)_/¯
```
