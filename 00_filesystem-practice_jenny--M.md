00\_filesystem-practice\_jenny--M.R
================
muralir
Wed Jan 31 23:05:56 2018

``` r
## First attempt: Just get it to work ----

list.files("~/R/RStudioConf/day1_s1_explore-libraries")
```

    ## [1] "01_explore-libraries_comfy.R"   "01_explore-libraries_jenny.R"  
    ## [3] "01_explore-libraries_spartan.R"

``` r
list.files("~/R/RStudioConf/day1_s1_explore-libraries", pattern = "\\.R$")
```

    ## [1] "01_explore-libraries_comfy.R"   "01_explore-libraries_jenny.R"  
    ## [3] "01_explore-libraries_spartan.R"

``` r
list.files(
  "~/R/RStudioConf/day1_s1_explore-libraries",
  pattern = "\\.R$",
  full.names = TRUE
)
```

    ## [1] "/home/muralir/R/RStudioConf/day1_s1_explore-libraries/01_explore-libraries_comfy.R"  
    ## [2] "/home/muralir/R/RStudioConf/day1_s1_explore-libraries/01_explore-libraries_jenny.R"  
    ## [3] "/home/muralir/R/RStudioConf/day1_s1_explore-libraries/01_explore-libraries_spartan.R"

``` r
from_files <- list.files(
  "~/R/RStudioConf/day1_s1_explore-libraries",
  pattern = "\\.R$",
  full.names = TRUE
)

(to_files <- basename(from_files))
```

    ## [1] "01_explore-libraries_comfy.R"   "01_explore-libraries_jenny.R"  
    ## [3] "01_explore-libraries_spartan.R"

``` r
file.copy(from_files, to_files)
```

    ## [1] TRUE TRUE TRUE

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny--M.html"    
    ## [2] "00_filesystem-practice_jenny--M.R"       
    ## [3] "00_filesystem-practice_jenny--M.spin.R"  
    ## [4] "00_filesystem-practice_jenny--M.spin.Rmd"
    ## [5] "01_explore-libraries_comfy.R"            
    ## [6] "01_explore-libraries_jenny.R"            
    ## [7] "01_explore-libraries_spartan.R"          
    ## [8] "explore-libraries.Rproj"                 
    ## [9] "README.md"

``` r
## Clean it out, so we can refine ----
file.remove(to_files)
```

    ## [1] TRUE TRUE TRUE

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny--M.html"    
    ## [2] "00_filesystem-practice_jenny--M.R"       
    ## [3] "00_filesystem-practice_jenny--M.spin.R"  
    ## [4] "00_filesystem-practice_jenny--M.spin.Rmd"
    ## [5] "explore-libraries.Rproj"                 
    ## [6] "README.md"

``` r
## Copy again, tighter code ---- USING base functions
# Compose the correct path appropriate for the current OS
from_dir <- file.path("~", "Desktop", "day1_s1_explore-libraries")
normalizePath(from_dir) # Relative to full paths
```

    ## Warning in normalizePath(from_dir): path[1]="/home/muralir/Desktop/
    ## day1_s1_explore-libraries": No such file or directory

    ## [1] "/home/muralir/Desktop/day1_s1_explore-libraries"

``` r
# Save the list of files with the full path name of the FROM directory (absolute paths)
from_files <- list.files(from_dir, pattern = "\\.R$", full.names = TRUE)
# Extract the file names alone, so we could use them for destination file names
to_files <- basename(from_files)
# Copy the files (to the current working directory)
file.copy(from_files, to_files) # Returns logicals for each file, to indicate whether it worked
```

    ## logical(0)

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny--M.html"    
    ## [2] "00_filesystem-practice_jenny--M.R"       
    ## [3] "00_filesystem-practice_jenny--M.spin.R"  
    ## [4] "00_filesystem-practice_jenny--M.spin.Rmd"
    ## [5] "explore-libraries.Rproj"                 
    ## [6] "README.md"

``` r
## Clean it out, so we can use fs ----
file.remove(to_files)
```

    ## logical(0)

``` r
list.files()
```

    ## [1] "00_filesystem-practice_jenny--M.html"    
    ## [2] "00_filesystem-practice_jenny--M.R"       
    ## [3] "00_filesystem-practice_jenny--M.spin.R"  
    ## [4] "00_filesystem-practice_jenny--M.spin.Rmd"
    ## [5] "explore-libraries.Rproj"                 
    ## [6] "README.md"

``` r
## Copy again, using fs ---- NOW USING fs file-system operations package!!! :-)
# Load the fs package to work on file system paths
library(fs)
# The brackets additionally prints the variable just assigned
(from_dir <- path_home("R", "RStudioConf", "day1_s1_explore-libraries"))
```

    ## /home/muralir/R/RStudioConf/day1_s1_explore-libraries

``` r
# Save the list of files with the full path name of the FROM directory (absolute paths)
# Regex also works, but we're using globbing
(from_files <- dir_ls(from_dir, glob = "*.R"))
```

    ## /home/muralir/R/RStudioConf/day1_s1_explore-libraries/01_explore-libraries_comfy.R
    ## /home/muralir/R/RStudioConf/day1_s1_explore-libraries/01_explore-libraries_jenny.R
    ## /home/muralir/R/RStudioConf/day1_s1_explore-libraries/01_explore-libraries_spartan.R

``` r
# Extract the file names alone, so we could use them for destination file names
(to_files <- path_file(from_files))
```

    ## 01_explore-libraries_comfy.R   01_explore-libraries_jenny.R   
    ## 01_explore-libraries_spartan.R

``` r
# Copy the files
(out <- file_copy(from_files, to_files)) # Gives out a vector of filenames
```

    ## 01_explore-libraries_comfy.R   01_explore-libraries_jenny.R   
    ## 01_explore-libraries_spartan.R

``` r
dir_ls()   # Similar to ls 
```

    ## 00_filesystem-practice_jenny--M.R
    ## 00_filesystem-practice_jenny--M.html
    ## 00_filesystem-practice_jenny--M.spin.R
    ## 00_filesystem-practice_jenny--M.spin.Rmd
    ## 01_explore-libraries_comfy.R
    ## 01_explore-libraries_jenny.R
    ## 01_explore-libraries_spartan.R
    ## README.md
    ## explore-libraries.Rproj

``` r
dir_info() # Similar to ls -la
```

    ##                                       path type    size permissions
    ## 1        00_filesystem-practice_jenny--M.R file   2.61K   rw-rw-r--
    ## 2     00_filesystem-practice_jenny--M.html file 731.07K   rw-rw-r--
    ## 3   00_filesystem-practice_jenny--M.spin.R file   2.61K   rw-rw-r--
    ## 4 00_filesystem-practice_jenny--M.spin.Rmd file   2.71K   rw-rw-r--
    ## 5             01_explore-libraries_comfy.R file   1.12K   rw-rw-r--
    ## 6             01_explore-libraries_jenny.R file   1.54K   rw-rw-r--
    ## 7           01_explore-libraries_spartan.R file     850   rw-rw-r--
    ## 8                                README.md file     108   rw-rw-r--
    ## 9                  explore-libraries.Rproj file     204   rw-rw-r--
    ##     modification_time    user   group device_id hard_links
    ## 1 2018-01-31 23:05:55 muralir muralir        47          1
    ## 2 2018-01-31 22:56:51 muralir muralir        47          1
    ## 3 2018-01-31 23:05:56 muralir muralir        47          1
    ## 4 2018-01-31 23:05:56 muralir muralir        47          1
    ## 5 2018-01-31 23:05:56 muralir muralir        47          1
    ## 6 2018-01-31 23:05:56 muralir muralir        47          1
    ## 7 2018-01-31 23:05:56 muralir muralir        47          1
    ## 8 2018-01-31 22:46:07 muralir muralir        47          1
    ## 9 2018-01-31 22:33:00 muralir muralir        47          1
    ##   special_device_id   inode block_size blocks flags generation
    ## 1                 0 1460043       4096     24     0          0
    ## 2                 0 1460055       4096   1480     0          0
    ## 3                 0 1459923       4096     24     0          0
    ## 4                 0 1460056       4096     24     0          0
    ## 5                 0 1460057       4096     24     0          0
    ## 6                 0 1460058       4096     24     0          0
    ## 7                 0 1460059       4096     24     0          0
    ## 8                 0 1459950       4096     24     0          0
    ## 9                 0 1459951       4096     24     0          0
    ##           access_time         change_time          birth_time
    ## 1 2018-01-31 23:05:55 2018-01-31 23:05:55 2018-01-31 23:05:55
    ## 2 2018-01-31 22:56:52 2018-01-31 22:56:51 2018-01-31 22:56:51
    ## 3 2018-01-31 23:05:56 2018-01-31 23:05:56 2018-01-31 23:05:56
    ## 4 2018-01-31 23:05:56 2018-01-31 23:05:56 2018-01-31 23:05:56
    ## 5 2018-01-31 23:05:56 2018-01-31 23:05:56 2018-01-31 23:05:56
    ## 6 2018-01-31 23:05:56 2018-01-31 23:05:56 2018-01-31 23:05:56
    ## 7 2018-01-31 23:05:56 2018-01-31 23:05:56 2018-01-31 23:05:56
    ## 8 2018-01-31 22:46:07 2018-01-31 22:46:07 2018-01-31 22:46:07
    ## 9 2018-01-31 22:37:16 2018-01-31 22:33:00 2018-01-31 22:33:00

``` r
## Sidebar: Why does Jenny name files this way? ----
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.2.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ─────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
ft <- tibble(files = dir_ls(glob = "*.R"))
ft
```

    ## # A tibble: 5 x 1
    ##   files                                 
    ##   <fs::path>                            
    ## 1 00_filesystem-practice_jenny--M.R     
    ## 2 00_filesystem-practice_jenny--M.spin.R
    ## 3 01_explore-libraries_comfy.R          
    ## 4 01_explore-libraries_jenny.R          
    ## 5 01_explore-libraries_spartan.R

``` r
ft %>%
  filter(str_detect(files, "explore"))
```

    ## # A tibble: 3 x 1
    ##   files                         
    ##   <fs::path>                    
    ## 1 01_explore-libraries_comfy.R  
    ## 2 01_explore-libraries_jenny.R  
    ## 3 01_explore-libraries_spartan.R

``` r
ft %>%
  mutate(files = path_ext_remove(files)) %>%
  separate(files, into = c("i", "topic", "flavor"), sep = "_")
```

    ## # A tibble: 5 x 3
    ##   i     topic               flavor       
    ##   <chr> <chr>               <chr>        
    ## 1 00    filesystem-practice jenny--M     
    ## 2 00    filesystem-practice jenny--M.spin
    ## 3 01    explore-libraries   comfy        
    ## 4 01    explore-libraries   jenny        
    ## 5 01    explore-libraries   spartan

``` r
dirs <- dir_ls(path_home("Desktop"), type = "directory")
(dt <- tibble(dirs = path_file(dirs)))
```

    ## # A tibble: 9 x 1
    ##   dirs                    
    ##   <fs::path>              
    ## 1 CharisSIL-5.000         
    ## 2 CharisSILCompact-5.000  
    ## 3 Kate-Syntax-Highlighting
    ## 4 Monologue               
    ## 5 PDF                     
    ## 6 PRAAT_Workshop          
    ## 7 PraatEx                 
    ## 8 efi                     
    ## 9 veracrypt-1.21-setup

``` r
dt %>%
  separate(dirs, into = c("day", "session", "topic"), sep = "_")
```

    ## Warning: Expected 3 pieces. Missing pieces filled with `NA` in 9 rows [1,
    ## 2, 3, 4, 5, 6, 7, 8, 9].

    ## # A tibble: 9 x 3
    ##   day                      session  topic
    ##   <chr>                    <chr>    <chr>
    ## 1 CharisSIL-5.000          <NA>     <NA> 
    ## 2 CharisSILCompact-5.000   <NA>     <NA> 
    ## 3 Kate-Syntax-Highlighting <NA>     <NA> 
    ## 4 Monologue                <NA>     <NA> 
    ## 5 PDF                      <NA>     <NA> 
    ## 6 PRAAT                    Workshop <NA> 
    ## 7 PraatEx                  <NA>     <NA> 
    ## 8 efi                      <NA>     <NA> 
    ## 9 veracrypt-1.21-setup     <NA>     <NA>

``` r
## Principled use of delimiters --> meta-data can be recovered from filename

## Clean it out, so we reset for workshop ----
file_delete(to_files)
dir_ls()
```

    ## 00_filesystem-practice_jenny--M.R
    ## 00_filesystem-practice_jenny--M.html
    ## 00_filesystem-practice_jenny--M.spin.R
    ## 00_filesystem-practice_jenny--M.spin.Rmd
    ## README.md
    ## explore-libraries.Rproj
