## First attempt: Just get it to work ----

list.files("~/Desktop/day1_s1_explore-libraries")

list.files("~/Desktop/day1_s1_explore-libraries", pattern = "\\.R$")

list.files(
  "~/Desktop/day1_s1_explore-libraries",
  pattern = "\\.R$",
  full.names = TRUE
)

from_files <- list.files(
  "~/Desktop/day1_s1_explore-libraries",
  pattern = "\\.R$",
  full.names = TRUE
)

(to_files <- basename(from_files))

file.copy(from_files, to_files)

list.files()

## Clean it out, so we can refine ----
file.remove(to_files)
list.files()

## Copy again, tighter code ---- USING base functions
# Compose the correct path appropriate for the current OS
from_dir <- file.path("~", "Desktop", "day1_s1_explore-libraries")
normalizePath(from_dir) # Relative to full paths
# Save the list of files with the full path name of the FROM directory (absolute paths)
from_files <- list.files(from_dir, pattern = "\\.R$", full.names = TRUE)
# Extract the file names alone, so we could use them for destination file names
to_files <- basename(from_files)
# Copy the files (to the current working directory)
file.copy(from_files, to_files) # Returns logicals for each file, to indicate whether it worked
list.files()

## Clean it out, so we can use fs ----
file.remove(to_files)
list.files()

## Copy again, using fs ---- NOW USING fs file-system operations package!!! :-)
# Load the fs package to work on file system paths
library(fs)
# The brackets additionally prints the variable just assigned
(from_dir <- path_home("R", "RStudioConf", "day1_s1_explore-libraries"))
# Save the list of files with the full path name of the FROM directory (absolute paths)
# Regex also works, but we're using globbing
(from_files <- dir_ls(from_dir, glob = "*.R"))
# Extract the file names alone, so we could use them for destination file names
(to_files <- path_file(from_files))
# Copy the files
(out <- file_copy(from_files, to_files)) # Gives out a vector of filenames
dir_ls()   # Similar to ls 
dir_info() # Similar to ls -la

## Sidebar: Why does Jenny name files this way? ----
library(tidyverse)
ft <- tibble(files = dir_ls(glob = "*.R"))
ft

ft %>%
  filter(str_detect(files, "explore"))

ft %>%
  mutate(files = path_ext_remove(files)) %>%
  separate(files, into = c("i", "topic", "flavor"), sep = "_")

dirs <- dir_ls(path_home("Desktop"), type = "directory")
(dt <- tibble(dirs = path_file(dirs)))
dt %>%
  separate(dirs, into = c("day", "session", "topic"), sep = "_")

## Principled use of delimiters --> meta-data can be recovered from filename

## Clean it out, so we reset for workshop ----
file_delete(to_files)
dir_ls()
