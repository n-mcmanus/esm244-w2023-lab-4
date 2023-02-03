library(tidyverse)
library(knitr)
library(kableExtra)
library(tictoc)
library(furrr)

mtcars %>% 
  map(mean) %>% 
  kable() %>% 
  kable_classic

mtcars %>% 
  map_dbl(mean) %>%  # dbl is short for double e.g numbers
  head() %>% kable() %>%
  kable_classic()

mtcars %>% 
  split(mtcars$cyl) %>%   #split is a base R so not part of the tidyverse
  map(~lm(mpg~wt,data = .)) # the . is passed from the pipe with .x of map

by_cyl <- mtcars %>%  split(mtcars$cyl)  # Store the dataset for predictions
mods <- by_cyl %>%  map(~lm(mpg ~ wt, data = .))
predictions<-map2(mods, by_cyl, predict) # Take my linear mods and use the data to predict mpg