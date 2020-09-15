# QuACK 2020 
# Week 4 - Data Cleaning and Tidyverse
# Practice
# Authors: Willa & Elena

#### Set options ####
# Set your stringAsFactors option to false!
# I always do this at the top of all of my scripts.
options(stringsAsFactors=FALSE)

#### 1. Check/Set your working directory ####
# Make sure you are where you want to be.
setwd("~/Documents/QuACK/Week3") # Or wherever this is for you!

#### 2. Load your data ####
# Data adapted from Allison Horst and her Palmer Penguins
# https://github.com/allisonhorst/palmerpenguins
# Load in penguin.csv
penguins <- read.csv('penguin.csv')


#### 3. Check for missing values ####

# i. Are there any missing values? (There are a few ways you can check for this.)
summary(penguins) # Tells you what columns
penguins[is.na(penguins)]


# ii. Remove those penguins!
penguins <- na.omit(penguins)



##### 4. Get to know some of these penguins ##### 

# i. Pull the all available info for penguin p5

p5 <- penguins[4,] #note it moved when we removed NAs
p5 <- penguins[penguins$penguin=='p5', ] # better move

# ii. How much does penguin p18 weigh? 

p18_weight<-penguins$body_mass_g[penguins$penguin=='p18']

# iii. Who is heavier p18 or p38?

p38_weight<-penguins$body_mass_g[penguins$penguin=='p38']

# P18

#### 5. On average, do Adelie or Gentoo penguins have longer bill length? ####

mean(penguins$bill_length_mm[penguins$species == "Adelie"])
mean(penguins$bill_length_mm[penguins$species == "Gentoo"])

#Gentoo


#### 6. Subsetting data ####
# In the following exerices, subset penguins using both bracket notation and the subset function
# i. Make a data frame of all the penguins that weigh more than p18
penguins_heavy <- penguins[penguins$weight > p18_weight,]
penguins_heavy2 <- subset(penguins, weight > p18_weight)

# ii. Make new data frames, one for each island. 

# Example for one island
penguins_Biscoe <- penguins[penguins$island == "Biscoe",]
penguins_Biscoe2 <- subset(penguins, island == "Biscoe")


# iii. Make a new data frame of all the Adelie penguins on Dream island.
penguins_AdelieBiscoe <- penguins[penguins$species == "Adelie" & penguins$island == "Dream", ]
penguins_AdelieBiscoe2 <- subset(penguins, species == "Adelie" & island == "Dream")

# iv. Do the same as in iii, but now only select the species, island, bill_length_mm, and sex columns for your new data frame
penguins_AdelieBiscoe3 <- penguins[penguins$species == "Adelie" & penguins$island == "Dream", c(1:3, 7)]
penguins_AdelieBiscoe4 <- penguins[penguins$species == "Adelie" & penguins$island == "Dream", c("species", "island", "bill_length_mm", "sex")]
penguins_AdelieBiscoe5 <- subset(penguins, species == "Adelie" & island == "Dream", select = c("species", "island", "bill_length_mm", "sex"))

#### 7. Challenge: What island has the most Adelie species ####
# Hint: Use table() function
table(penguins$species, penguins$island)