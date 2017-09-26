# You should create one R script called run_analysis.R that does the following.
#
# 1 - Merges the training and the test sets to create one data set.
# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
# 3 - Uses descriptive activity names to name the activities in the data set
# 4 - Appropriately labels the data set with descriptive variable names.
# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Setup

library(data.table)
library(plyr)

setwd(".")
path <- getwd()

# Download dataset file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dataset_filename <- "dataset.zip"

# Downloads dataset file unless it already exists
if(!file.exists(file.path(path, dataset_filename))) {
  download.file(url, file.path(path, dataset_filename))
}

# Unzip dataset file
unzip(zipfile = dataset_filename)

# Data directory
data_path <- file.path(path, "UCI\ HAR\ Dataset")

# Step 1 - Merges the training and the test sets to create one data set.
# ------------------------------------------------------------------------------

# Reads subject data files
data_subject_train <- read.table(file.path(data_path, "train", "subject_train.txt"))
data_subject_test  <- read.table(file.path(data_path, "test" , "subject_test.txt" ))

# Reads activity data files
data_activity_train <- read.table(file.path(data_path, "train", "y_train.txt"))
data_activity_test  <- read.table(file.path(data_path, "test" , "y_test.txt" ))

# Reads log data files
data_train <- read.table(file.path(data_path, "train", "X_train.txt"))
data_test <- read.table(file.path(data_path, "test", "X_test.txt"))

# Merges train and test data tables
data_subject <- rbind(data_subject_train, data_subject_test)
data_activity <- rbind(data_activity_train, data_activity_test)
data_log <- rbind(data_train, data_test)

# Step 2 - Extract only the measurements on the mean and standard deviation for
# each measurement
# ------------------------------------------------------------------------------

# Reads features names
features <- read.table(file.path(data_path, "features.txt"))

# selects only features columns that contains "mean()" or "std()" in their names
selected_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset `mean` and `std` columns from `data_log`
data_log <- data_log[, selected_features]

# correct the column names
names(data_log) <- features[selected_features, 2]

# Step 3 - Uses descriptive activity names to name the activities in the data set
# ------------------------------------------------------------------------------

# Reads the activity labels file
activity_labels <- read.table(file.path(data_path, "activity_labels.txt"))

# update values with correct activity names
data_activity[, 1] <- activity_labels[data_activity[, 1], 2]

# correct column name
names(data_activity) <- "activity"

# Step 4 - Appropriately labels the data set with descriptive variable names.
# ------------------------------------------------------------------------------

# renames column name
names(data_subject) <- "subject"

# combines all the data to a single data table
combined_data <- cbind(data_log, data_activity, data_subject)

# Step 5 - From the data set in step 4, creates a second, independent tidy data
# set with the average of each variable for each activity and each subject.
# ------------------------------------------------------------------------------

# calculates the average of each variable EXCEPT "subject" and "activity" which
# are not continuous (or measurements) data
averages_data <- ddply(combined_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

# Writes the tidy data table to a .txt file
write.table(averages_data, file = "tidy_averages_data.txt", row.name = FALSE)
