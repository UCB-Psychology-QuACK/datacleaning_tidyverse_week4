# QuACK 2020 
# Week 4 - Data Cleaning and Tidyverse
# Practice 2
# Authors: Elena & Willa

#### Set options ####
# Set your stringAsFactors option to false!
# I always do this at the top of all of my scripts.


#### Check/Set your working directory ####
# Make sure you are where you want to be.


#### Load your data ####
# Data adapted from Allison Horst and her Palmer Penguins
# https://github.com/allisonhorst/palmerpenguins
# Load in penguin.csv




#### Problem 1 ####
# Do the following using tidyverse functions

# a) Make a data frame of all the penguins that weigh more than p18


# b) Make a new data frame of all the Adelie penguins on Dream island.


# c) Do the same as in iii, but now only select the species, island, bill_length_mm, and sex columns for your new data frame


#### Problem 2 ####

# Prepare your data for your analysis: 
# 1) Remove all the rows with any missing data
# 2) Keep only the penguins on Dream Island 
# 3) Create a new column that is the ratio of bill_length_mm to bill_depth_mm
# 4) Keep only data from before 2009
# 5) Create a new column that labels penguins greater than or equal to the mean
# body_mass_g of the penguins in this data frame as "heavy", and those who weigh
# less than that as "light" [If you get stuck on this, label those weighing more
# than 4200 g (inclusive) as "heavy", and less than that as "light".]
# 6) Get rid of the flipper column.
# Challenge: Make columns factors that should be factors.

# Feel free to combine steps (i.e., do more than one thing in a given function) where you see fit!






#### Problem 3 ####
# Answer the following questions using the summarise function. You may need to use group_by() as well!

# a) On average, do Adelie or Gentoo penguins have longer bill length? (This one is a little tricky! Don't forget you can look at ?mean for some help!)


# b) On which island do the penguins weigh the most on average? Which island has the most variation in body mass?


# C) On which island do the Adelie penguins weigh the most on average? Which island has the most variation in body mass?


# Challenge: What island has the most Adelie species ####
# Hint: There are two ways to do this! 
# Option 1: Use summarise and a function we haven't seen yet, n() that counts
# the number of rows in a given grouping [type in ?n() to the console]
# Option 2: Instead of summarise, use a function called count(), which acts
# similarly to n() but is not used inside of summarise, and rather stands on its
# own! [type in ?count() into the console]



