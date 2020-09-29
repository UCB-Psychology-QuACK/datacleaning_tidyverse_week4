# Quack 2020
# Week 4 - Data Cleaning
# Elena Leib

#### Check/Set your working directory ####
# Make sure you are where you want to be.

# I always open my script from my working directory so it automatically sets the wd in RStudio.


#### Set options ####
# Set your stringAsFactors option to false!
# I always do this at the top of all of my scripts.
options(stringsAsFactors=FALSE)

#### Warm up ####

# subj_ages is a vector of participants' ages for all 100 participants in our study
# (Don't worry about the rnorm() function for right now, we will get to this in
# later weeks. For now, what you need to know is that it is randomly drawing
# numbers from a normal distribution with a mean of 18 and sd of 5. This is a
# nifty function for creating synthetic data! We will return to this in a couple
# weeks.)

subj_ages <- rnorm(100, mean = 18, sd = 5)

# 1) Make two new vectors, one with all the participants' ages who are adults (i.e., 18 and older), and one with all the participants' ages who are minors. How many participants are in each group?
# Hint: Use logical indexing (what we learned last week)
subj_adults <- subj_ages[subj_ages >= 18]
length(subj_adults) # 41
subj_minors <- subj_ages[subj_ages < 18]
length(subj_minors) # 59

# 2) Make a new vector of all the participants' ages who are between 16 and 20 years old (inclusive of these boundary ages). How many participants are in this group?
subj_16to20 <- subj_ages[subj_ages >= 16 & subj_ages <= 20]
length(subj_16to20) # 36


#### ...Picking up where we left off last week... ####

# Here is a more practical example.
age <- c(5, 10, NA, 6, 9, NA, 8)
#        age        5,      10,     NA,     6,      9,      NA,     8
#  is.na(age)       FALSE   FALSE   TRUE    FALSE   FALSE   TRUE    FALSE
# !is.na(age)       TRUE    TRUE    FALSE   TRUE    TRUE    FALSE   TRUE

is.na(age)
!is.na(age) # We want to keep the values that are NOT NA
age[!is.na(age)]

# Now let's do this for the whole data frame!
subjid <- 1:7
age <- c(5, 10, NA, 6, 9, NA, 8)
gender <- c("m", "m", "f", "m","other", "f", NA)
bilingual <- rep(c(0, 1), length.out = length(subjid))

df <- data.frame(subjid, age, gender, bilingual)
df$gender <- factor(df$gender)
df$bilingual <- factor(df$bilingual)
df

# Let's check out our data frame
View(df)
str(df)
summary(df)


#### Removing NAs ####

# To check for and get rid of NAs (and the row that has that NA) for one column of data:
(df.noAgeNA <- df[!is.na(df$age),])
# But this makes us look for NAs only in the age column. And sometimes you might want to do that!
# Example, you only want to eliminate people missing data in a certain column, but they can have NAs for other things.

# To omit ALL rows that have ANY NAs:
(df.clean <- na.omit(df))


#### Now, let's learn more about our data ####

# Let's look at all the data for subject 4
df.clean[4,] #... doesn't work anymore! Got data for subject 5!
df.clean[3,] # ok, but not the best, better yet, select when subjid == 4
df.clean[df.clean$subjid == 4,]

# How old is subject 5?
df.clean$age[df.clean$subjid == 5]

# Get only participants who are older than 6
df.clean[df.clean$age > 6,]
# This is the subset of the data with participants older than 6


# Subset only the subjects that are bilingual
df.clean[df.clean$bilingual == 1,]

# Subset only the subjects who are older than 6 AND bilingual
df.clean[df.clean$age > 6 & df.clean$bilingual == 1,]
# Only gives us one person!

#### Subset function ####
# We can also use the subset function to do this same thing.

df.old <- subset(df.clean, age > 6)

# Can also select a certain set of columns if you don't want all of them
df.old_colChange <- subset(df.clean, age > 6, select=c("subjid", "age"))
