# QuACK 2020 
# Week 4 - Data Cleaning and Tidyverse
# Class Part 2
# Authors: Elena & Willa

#### Set options ####
# Set your stringAsFactors option to false!
# I always do this at the top of all of my scripts.


#### NEW! Import packages ####
# If this is your first time using a package, you will need to install it first!

# Install packages
# In the bottom right window, click on the 'Packages' tab. Then click 'Install' and type in the name of the package you want to install.
# In this case, we want to install 'tidyverse' and 'tidylog'. 
# Type in the package (it should autofill), and click install.

# Alternatively, you can type:
install.packages("tidyverse")
install.packages("tidylog")

# Import packages
library(tidyverse)
library(tidylog)


#### 1. Check/Set your working directory ####
# Make sure you are where you want to be.


#### 2. Load your data ####
# Data adapted from mtcars, a built in R data set (see ?mtcars for more information)
mtcars_missingData <- read.csv("mtcars_missingData.csv")
?mtcars


#### 3. Look at your data ####
# Like always, we want to look at our data
View(mtcars_missingData)
str(mtcars_missingData)
summary(mtcars_missingData)


#### Introduction to %>% operator (piping) ####

# Syntax that allows us to do a bunch of things to one object without needing to
# keep using the assignment opperator over and over again. Using a pipe (%>%),
# we can do a sequence of actions to an object, and store only the result.

# Using this feature makes code more organized and typically makes it easier to
# read and follow. (Still need good comments though!)

# From the tidyverse style guide (https://style.tidyverse.org/index.html):
# Use %>% to emphasise a sequence of actions, rather than the object that the actions are being performed on.
# Avoid using the pipe when:
#   - You need to manipulate more than one object at a time. Reserve pipes for a
#   sequence of steps applied to one primary object.
#   - There are meaningful intermediate objects that could be given informative
#   names.

# Tidyverse functions we will be learning about this week and next!
# - filter
# - select
# - mutate
# - case_when
# - drop_na
# - summarise
# - group_by


# For all these examples, we are going to do it in both base R and tidyverse!


#### Subsetting data in tidyverse ####

# Subset only cars that get better than 20 mpg
mtcars_fuelEfficient1 <- mtcars_missingData[mtcars_missingData$mpg > 20,]
mtcars_fuelEfficient2 <- subset(mtcars_missingData, mpg > 20)
mtcars_fuelEfficient <- mtcars_missingData %>% 
  filter(mpg > 20)


# Now subset only cars that get better than 20 mpg and are manual transmission
mtcars_fuelEfficient_manual1 <- mtcars_missingData[mtcars_missingData$mpg > 20 & mtcars_missingData$am == 1,]
mtcars_fuelEfficient_manual1_1 <- mtcars_missingData[mtcars_missingData$mpg > 20 & 
                                                       !is.na(mtcars_missingData$am) & 
                                                       mtcars_missingData$am == 1,]
mtcars_fuelEfficient_manual2 <- subset(mtcars_missingData, mpg > 20 & am == 1)

mtcars_fuelEfficient_manual <- mtcars_missingData %>% 
  filter(mpg > 20, am == 1)


#### Selecting columns ####
# Imagine we don't care about most of these columns. We only want the car name, mpg, number of cylinders (cyl), and horsepower (hp)

mtcars_abrv1_1 <- mtcars_missingData[, c(1, 2, 3, 5)]
mtcars_abrv1_2 <- mtcars_missingData[, c("name", "mpg", "cyl", "hp")]
mtcars_abrv2_1 <- subset(mtcars_missingData, select = c("name", "mpg", "cyl", "hp"))
mtcars_abrv2_2 <- subset(mtcars_missingData, select = c(name, mpg, cyl, hp))

mtcars_abrv <- mtcars_missingData %>% 
  select(name, mpg, cyl, hp)

# You can also use select to say what columns you DON'T want to keep by putting a negative before the column name or in front of a vector of column names
mtcars_abrv3 <- mtcars_missingData %>% 
  select(-am, -c(qsec, vs, gear))


#### Combining subsetting (i.e., filtering) [rows] and selecting [cols] ####
# What if we want to select only the name, mpg, cyl, and hp columns for the fuel efficient manual cars?
# This starts to get messy in Base R!
# There are a few ways we can do it. We could do it in one step:
mtcars_fuelEfficient_manual_abrv1 <- mtcars_missingData[mtcars_missingData$mpg > 20 & 
                                                         !is.na(mtcars_missingData$am) & 
                                                         mtcars_missingData$am == 1, 
                                                       c("name", "mpg", "cyl", "hp")]

# Honestly though, that is pretty ugly and hard to read!
# Let's try this in two steps and see if it helps:
mtcars_fuelEfficient_manual1_1 <- mtcars_missingData[mtcars_missingData$mpg > 20 & 
                                                       !is.na(mtcars_missingData$am) & 
                                                       mtcars_missingData$am == 1,]
mtcars_fuelEfficient_manual_abrv2 <- mtcars_fuelEfficient_manual1_1[, c("name", "mpg", "cyl", "hp")]
# That is also hard to follow because the first df that is saved is useless for us. We are cluttering up our Global Environment, and it is still hard to read.

# Let's try using subset:
mtcars_fuelEfficient_manual_abrv3 <- subset(mtcars_missingData, mpg > 20 & am == 1, 
                                            select = c(name, mpg, cyl, hp))

# Not too bad, but we can do even better!

# ENTER THE PIPE OPERATOR!!! And dplyr functions!
mtcars_fuelEfficient_manual_abrv <-  mtcars_missingData %>% 
  filter(mpg > 20, am == 1) %>% 
  select(name, mpg, cyl, hp)


#### Creating new columns ####
# Let's add two columns to our data:
#   1) A column that indicates calculates a ratio of mpg to horsepower
#   2) A column that says "automatic" or "manual" because we don't want 0 and 1 anymore for the am column
mtcars_missingData$ratio_mpg.hp1 <- mtcars_missingData$mpg / mtcars_missingData$hp
mtcars_missingData$transmission1 <- ifelse(mtcars_missingData$am == 0, "automatic", "manual")

mtcars_missingData <- mtcars_missingData %>% 
  mutate(ratio_mpg.hp = mpg / hp,
         transmission = case_when(am == 0 ~ "automatic",
                                  am == 1 ~ "manual"))


#### Removing missing data ####
# Remove all rows that are missing data for am
mtcars_amClean1 <- mtcars_missingData[!is.na(mtcars_missingData$am),]
mtcars_amClean2 <- subset(mtcars_missingData, !is.na(am))
mtcars_amClean <- mtcars_missingData %>% 
  filter(!is.na(am))

# Now I want to remove all rows that have any NAs
mtcars_rmNA1 <- na.omit(mtcars_missingData)
mtcars_rmNA <- mtcars_missingData %>% 
  drop_na()

#### Putting it together ####
# Suppose we collect our data, and our mtcars_missingData is the version of the raw data we are going to begin working with.
# We know off the bat that we want to:
# 1) Remove all rows with any missing data
# 2) Add two new columns, one for a ratio of mpg over horsepower and one that
# recodes the am column in words so it is more readable.
# 3) Analyze only fuel efficient manual cars for our first analysis
# 4) Select only the name, mpg, cyl, hp, and our new transmision columns because
# those are our only variables of interest

# Of course this can be done in Base R! But I'm not going to bother because it
# will be too long and hard to follow... each step needs to be its own line,
# which is fine except that I have to create a new object every time! That's
# annoying! I don't want all those intermediate data frames in my Global
# Environment. I have no use for them. I only want the final product!

# Again, enter piping. With pipes, we can do a sequence of actions to our data
# frame without needing to save the intermediate steps!

mtcars_analysis <- mtcars_missingData %>% 
  drop_na() %>% 
  mutate(ratio_mpg.hp = mpg / hp,
         transmission = case_when(am == 0 ~ "automatic",
                                  am == 1 ~ "manual")) %>% 
  filter(mpg > 20 & am == 1) %>% 
  select(name, mpg, cyl, hp, transmission)
  


# Maybe we just want to do this to clean:
mtcars_clean <- mtcars_missingData %>% 
  drop_na() %>% 
  mutate(ratio_mpg.hp = mpg / hp,
         transmission = case_when(am == 0 ~ "automatic",
                                  am == 1 ~ "manual")) %>% 
  select(name, mpg, cyl, hp, transmission)

#### Summarising our data ####
# Suppose I am interested on whether automatic transmission cars are more fuel efficient than manual cars.
# dplyr has an easy way to look at our data this way

mtcars_transmissionSummary <- mtcars_clean %>% 
  group_by(transmission) %>% 
  summarise(mpg_mean = mean(mpg),
            mpg_sd = sd(mpg),
            hp_mean = mean(hp),
            hp_sd = sd(hp)) %>% 
  ungroup()

mtcars_summary_limited <- mtcars_clean %>% 
  summarise(mpg_mean = mean(mpg),
            mpg_sd = sd(mpg),
            hp_mean = mean(hp),
            hp_sd = sd(hp))



#### More information ####
# Tidy Cheat Sheet - a good reference for helping to figure out what function to use
# https://rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

# Illustrations to help you understand what you are doing when you use a function!
# https://github.com/allisonhorst/stats-illustrations