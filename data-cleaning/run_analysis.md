---
Title: "Getting and Cleaning Data Course Project"
author: "Jostein Barry-Straume"
date: "April 18, 2017"
output: html_document
---

**Instructions**
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

**Review criteria**

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

**Getting and Cleaning Data Course Project**
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1. A tidy data set as described below
2. A link to a Github repository with your script for performing the analysis
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

>Here is the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

*Good luck!*

# Set up the required packages

```r
packages <- c("downloader", "dplyr", "knitr", "markdown", "data.table")
sapply(packages, require, character.only = TRUE, quietly = TRUE)
```

```
## downloader      dplyr      knitr   markdown data.table 
##       TRUE       TRUE       TRUE       TRUE       TRUE
```
# Download running data and unzip it

```r
getwd()
```

```
## [1] "/Users/Jostein/Projects/datasciencecoursera/data-cleaning"
```

```r
setwd("/Users/Jostein/Projects/datasciencecoursera/data-cleaning")
path <- getwd()
fileName <- "data-set.zip"
if (!file.exists(fileName)) {
	urlFile = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	download(urlFile, dest = "/Users/Jostein/Projects/datasciencecoursera/data-cleaning/data-set.zip", mode ="wb")
}
if (!file.exists("UCI HAR Dataset")) {
	unzip("data-set.zip", exdir = "./")
}
```

# Create the test data frame

```r
xTest <- read.csv("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
yTest <- read.csv("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
subjectTest <- read.csv("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)
test <- data.frame(subjectTest, yTest, xTest)
```

# Create the subject data frame

```r
xTrain <- read.csv("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
yTrain <- read.csv("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
subjectTrain <- read.csv("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)
train <- data.frame(subjectTrain, yTrain, xTrain)
```

# Combine test and subject to create the run data frame

```r
run <- rbind(train, test)
```

# Create appropriate labels  for the data set

```r
features <- read.csv("UCI HAR Dataset/features.txt", sep = "", header = FALSE)
columnNames <- as.vector(features[,2])
colnames(run) <- c("subject_id", "activity_labels", columnNames)
validColumnNames <- make.names(names = names(run), unique = TRUE, allow_ = TRUE)
names(run) <- validColumnNames
```

# Narrow the data set

```r
run <- select(run, contains("subject"), contains("label"), contains("mean"), contains("std"), -contains("freq"), -contains("angle"))
activityLabels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep = "" , header = FALSE)
run$activity_labels <- as.character(activityLabels[match(run$activity_labels, activityLabels$V1), 'V2'])
```

# Tidy up variable names

```r
setnames(run, colnames(run), gsub("\\(\\)", "", colnames(run)))
setnames(run, colnames(run), gsub("-", "_", colnames(run)))
setnames(run, colnames(run), gsub("[.]", "", colnames(run)))
setnames(run, colnames(run), gsub("mean", "Mean", colnames(run)))
setnames(run, colnames(run), gsub("std", "Std", colnames(run)))
```
# Create the second, tidy data set
## and write it to an appropriately named file

```r
summaryRun <- group_by(run, subject_id, activity_labels)
summarise_each(summaryRun, funs(mean))
```

```
## Source: local data frame [180 x 68]
## Groups: subject_id [?]
## 
##    subject_id    activity_labels tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ
##         <int>              <chr>         <dbl>         <dbl>         <dbl>
## 1           1             LAYING     0.2215982  -0.040513953    -0.1132036
## 2           1            SITTING     0.2612376  -0.001308288    -0.1045442
## 3           1           STANDING     0.2789176  -0.016137590    -0.1106018
## 4           1            WALKING     0.2773308  -0.017383819    -0.1111481
## 5           1 WALKING_DOWNSTAIRS     0.2891883  -0.009918505    -0.1075662
## 6           1   WALKING_UPSTAIRS     0.2554617  -0.023953149    -0.0973020
## 7           2             LAYING     0.2813734  -0.018158740    -0.1072456
## 8           2            SITTING     0.2770874  -0.015687994    -0.1092183
## 9           2           STANDING     0.2779115  -0.018420827    -0.1059085
## 10          2            WALKING     0.2764266  -0.018594920    -0.1055004
## # ... with 170 more rows, and 63 more variables: tGravityAccMeanX <dbl>,
## #   tGravityAccMeanY <dbl>, tGravityAccMeanZ <dbl>,
## #   tBodyAccJerkMeanX <dbl>, tBodyAccJerkMeanY <dbl>,
## #   tBodyAccJerkMeanZ <dbl>, tBodyGyroMeanX <dbl>, tBodyGyroMeanY <dbl>,
## #   tBodyGyroMeanZ <dbl>, tBodyGyroJerkMeanX <dbl>,
## #   tBodyGyroJerkMeanY <dbl>, tBodyGyroJerkMeanZ <dbl>,
## #   tBodyAccMagMean <dbl>, tGravityAccMagMean <dbl>,
## #   tBodyAccJerkMagMean <dbl>, tBodyGyroMagMean <dbl>,
## #   tBodyGyroJerkMagMean <dbl>, fBodyAccMeanX <dbl>, fBodyAccMeanY <dbl>,
## #   fBodyAccMeanZ <dbl>, fBodyAccJerkMeanX <dbl>, fBodyAccJerkMeanY <dbl>,
## #   fBodyAccJerkMeanZ <dbl>, fBodyGyroMeanX <dbl>, fBodyGyroMeanY <dbl>,
## #   fBodyGyroMeanZ <dbl>, fBodyAccMagMean <dbl>,
## #   fBodyBodyAccJerkMagMean <dbl>, fBodyBodyGyroMagMean <dbl>,
## #   fBodyBodyGyroJerkMagMean <dbl>, tBodyAccStdX <dbl>,
## #   tBodyAccStdY <dbl>, tBodyAccStdZ <dbl>, tGravityAccStdX <dbl>,
## #   tGravityAccStdY <dbl>, tGravityAccStdZ <dbl>, tBodyAccJerkStdX <dbl>,
## #   tBodyAccJerkStdY <dbl>, tBodyAccJerkStdZ <dbl>, tBodyGyroStdX <dbl>,
## #   tBodyGyroStdY <dbl>, tBodyGyroStdZ <dbl>, tBodyGyroJerkStdX <dbl>,
## #   tBodyGyroJerkStdY <dbl>, tBodyGyroJerkStdZ <dbl>,
## #   tBodyAccMagStd <dbl>, tGravityAccMagStd <dbl>,
## #   tBodyAccJerkMagStd <dbl>, tBodyGyroMagStd <dbl>,
## #   tBodyGyroJerkMagStd <dbl>, fBodyAccStdX <dbl>, fBodyAccStdY <dbl>,
## #   fBodyAccStdZ <dbl>, fBodyAccJerkStdX <dbl>, fBodyAccJerkStdY <dbl>,
## #   fBodyAccJerkStdZ <dbl>, fBodyGyroStdX <dbl>, fBodyGyroStdY <dbl>,
## #   fBodyGyroStdZ <dbl>, fBodyAccMagStd <dbl>,
## #   fBodyBodyAccJerkMagStd <dbl>, fBodyBodyGyroMagStd <dbl>,
## #   fBodyBodyGyroJerkMagStd <dbl>
```

```r
write.table(summaryRun, file = "summary_run_data.txt", row.names = FALSE)
#write.table(summarise_each(summaryRun, funs(mean)), file = "summary_run_data.txt", row.names = FALSE)
```

# Export variable names for codebook

```r
write.csv(names(summaryRun), file = "variable_names_codebook.csv", row.names = FALSE, col.names = FALSE)
```

```
## Warning in write.csv(names(summaryRun), file =
## "variable_names_codebook.csv", : attempt to set 'col.names' ignored
```


# Create codebook convert to HTML

```r
knit("summary_run_data.txt", output = "codebook.md", encoding = "ISO8859-1", quiet = TRUE)
```

```
## [1] "codebook.md"
```

```r
markdownToHTML("codebook.md", "codebook.html")
```
