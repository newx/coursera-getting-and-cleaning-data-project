# Code Book

This code book summarizes all steps performed by `run_analysis.R` script to
clean up the data and outputs the resulting tidy data file named
"tidy_averages_data.txt".

## Data Source

The dataset used is "Human Activity Recognition Using Smartphones" which can be
found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# STEPS PERFORMED

- Downloads dataset .zip file unless it already exists on the working directory.
- Unzip dataset .zip file.
- Loads and merges all similar data using `rbind`
- Extracts only columns with mean and standard deviation measurements from the
  dataset.
- Replaces activity labels codes (1:6) with their respective activity names extracted
  from `activity_labels.txt`.
- Updates columns names on the whole dataset with descriptive variable names.
- Combines all data into a single dataset.
- Calculates the average of each measurement.
- Export the resulting tidy data to a .txt file names "tidy_averages_data.txt"
  using `write.table`.

# CODE VARIABLES

* `url` - original dataset URL.
* `path` - current working directory.
* `dataset_filename` - compressed dataset file name.
* `data_path` - uncompressed dataset directory path.
* `data_subject_train`, `data_subject_test`, `data_activity_train`, `data_activity_test`,
  `data_train`, `data_test` - contains original data from downloaded files.
* `data_subject`, `data_activity`, `data_log` - combined similar data.
* `features` - contains the correct column names for `data_train`.
* `selected_features` - features columns that contains "mean()" or "std()" in their names.
* `data_log` - a subset of data combined from `data_train` and `data_test` that
  only contains columns with mean and standard deviation measurements.
* `activity_labels` - contains activity labels names.
* `combined_data` - combines `data_log`, `data_activity`, `data_subject` into a
  big dataset.
* `averages_data` - contains averages for each measurement which were calculated
  using `ddply()` from `plyr` package to apply `colMeans()` for each observation
  measurement.

# TIDY DATA SET VARIABLES

- `subject` - id of a person who participated in the experiement. Integer ranging from `1` to `30`
- `activity` - type of activity performed by the person. Factor with levels `LAYING`, `SITTING`, `STANDING`, `WALKING`, `WALKING_DOWNSTAIRS`, `WALKING UPSTAIRS`

  Other 66 numeric columns with measurements that were taken by accelerometer and gyroscope during the experiment:
  - `tBodyAccMeanX`
  - `tBodyAccMeanY`
  - `tBodyAccMeanZ`
  - `tBodyAccStdX`
  - `tBodyAccStdY`
  - `tBodyAccStdZ`
  - `tGravityAccMeanX`
  - `tGravityAccMeanY`
  - `tGravityAccMeanZ`
  - `tGravityAccStdX`
  - `tGravityAccStdY`
  - `tGravityAccStdZ`
  - `tBodyAccJerkMeanX`
  - `tBodyAccJerkMeanY`
  - `tBodyAccJerkMeanZ`
  - `tBodyAccJerkStdX`
  - `tBodyAccJerkStdY`
  - `tBodyAccJerkStdZ`
  - `tBodyGyroMeanX`
  - `tBodyGyroMeanY`
  - `tBodyGyroMeanZ`
  - `tBodyGyroStdX`
  - `tBodyGyroStdY`
  - `tBodyGyroStdZ`
  - `tBodyGyroJerkMeanX`
  - `tBodyGyroJerkMeanY`
  - `tBodyGyroJerkMeanZ`
  - `tBodyGyroJerkStdX`
  - `tBodyGyroJerkStdY`
  - `tBodyGyroJerkStdZ`
  - `tBodyAccMagMean`
  - `tBodyAccMagStd`
  - `tGravityAccMagMean`
  - `tGravityAccMagStd`
  - `tBodyAccJerkMagMean`
  - `tBodyAccJerkMagStd`
  - `tBodyGyroMagMean`
  - `tBodyGyroMagStd`
  - `tBodyGyroJerkMagMean`
  - `tBodyGyroJerkMagStd`
  - `fBodyAccMeanX`
  - `fBodyAccMeanY`
  - `fBodyAccMeanZ`
  - `fBodyAccStdX`
  - `fBodyAccStdY`
  - `fBodyAccStdZ`
  - `fBodyAccJerkMeanX`
  - `fBodyAccJerkMeanY`
  - `fBodyAccJerkMeanZ`
  - `fBodyAccJerkStdX`
  - `fBodyAccJerkStdY`
  - `fBodyAccJerkStdZ`
  - `fBodyGyroMeanX`
  - `fBodyGyroMeanY`
  - `fBodyGyroMeanZ`
  - `fBodyGyroStdX`
  - `fBodyGyroStdY`
  - `fBodyGyroStdZ`
  - `fBodyAccMagMean`
  - `fBodyAccMagStd`
  - `fBodyBodyAccJerkMagMean`
  - `fBodyBodyAccJerkMagStd`
  - `fBodyBodyGyroMagMean`
  - `fBodyBodyGyroMagStd`
  - `fBodyBodyGyroJerkMagMean`
  - `fBodyBodyGyroJerkMagStd`
