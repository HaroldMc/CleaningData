# CleaningData ReadMe

The data file used for this project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## The run_analysis.R script creates a tidy data set by doing the following:

### Combine the related train and test files

* Read and merge X_train.txt and X_test.txt into a single mergedFeatures dataframe
* Read and merge Y_train.txt and Y_test.txt into a single mergedActivity dataframe
* Read and merge subject_train.txt and subject_test.txt into a single mergedSubject dataframe

### Add names to the appropriate areas

* Adds the names "Subject" and "Activity" to the mergedSubject and mergedActivity dataframes.
* Uses the feature.txt file and assigns the names to the variable featureNames. And uses the featureNames dataframe to add names to the mergedFeatures dataframe.

### Combine the dataframes into one dataframe
* The Subject and Activity dataframes are combined using cbind.
* The resulting dataframe is then merged with the mergedFeatures data frame. 

### Subset the resulting dataframe
* Find all of the names with mean() or std() in their name and use it to subset the completeData dataframe

### Make dataframe more human readable friendly
* Substitute activity labels for the activity numbers
* Expand abbreviations to more human friendly terms

### Create a tidy data set with the means. 
