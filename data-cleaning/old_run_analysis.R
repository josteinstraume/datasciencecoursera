Getting and Cleaning Data Course Project

**bold**Instructions**bold**
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

**bold**Review criteria**bold**
1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

**bold**Getting and Cleaning Data Course Project**
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

# You should create one R script called run_analysis.R that does the following.

# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set
#  with the average of each variable for each activity and each subject.

# Set up the required packages in order to complete this project
# install.packages("easypackages", "downloader", "dplyr", "knitr", "markdown")
# myPackages <- c("easypackages", "downloader", "dplyr", "knitr", "markdown")
# libraries(myPackages)

library("downloader")
library("dplyr")
library("knitr")
library("markdown")
library("data.table")

# Download running data and unzipping it
getwd()
setwd("/Users/Jostein/Projects/datasciencecoursera/data-cleaning")
path <- getwd()
urlFile = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(urlFile, dest = "/Users/Jostein/Projects/datasciencecoursera/data-cleaning/data-set.zip", mode ="wb")
unzip("data-set.zip", exdir = "./")

# Create the test data frame
xTest <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
yTest <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
subjectTest <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
test <- data.frame(subjectTest, yTest, xTest)

# Create the subject data frame
xTrain <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
yTrain <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
subjectTrain <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
train <- data.frame(subjectTrain, yTrain, xTrain)

# Combine test and subject to create the run data frame
run <- rbind(train, test)

# Create appropriate labels  for the data set
features <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
columnNames <- as.vector(features[,2])
colnames(run) <- c("subject_id", "activity_labels", columnNames)
validColumnNames <- make.names(names = names(run), unique = TRUE, allow_ = TRUE)
names(run) <- validColumnNames

# Narrow the data set
run <- select(run, contains("subject"), contains("label"), contains("mean"), contains("std"), -contains("freq"), -contains("angle"))

activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "" , header = FALSE)

run$activity_labels <- as.character(activityLabels[match(run$activity_labels, activityLabels$V1), 'V2'])

# Tidy up variable names
setnames(run, colnames(run), gsub("\\(\\)", "", colnames(run)))
setnames(run, colnames(run), gsub("-", "_", colnames(run)))
setnames(run, colnames(run), gsub("BodyBody", "Body", colnames(run)))

summaryRun <- group_by(run, subject_id, activity_labels)
summarise_each(summaryRun, funs(mean))

# Create the second, tidy data set and write it to an appropriately named file
write.table(summaryRun, file = "summary_run_data.txt", row.names = FALSE)

# Create codebook convert to HTML
knit("summary_run_data.txt", output = "codebook.md", encoding = "ISO8859-1", quiet = TRUE)
markdownToHTML("codebook.md", "codebook.html")

