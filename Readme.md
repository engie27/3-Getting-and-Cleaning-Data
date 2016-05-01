Getting and Cleaning Data Course Project
========================================================

Purpose 
-----------------

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. 

You will be required to submit: 

1. a tidy data set as described below, 
2. a link to a Github repository with your script for performing the analysis
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called `CodeBook.md`. 
4. You should also include a `Readme.md` in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

Objectives
-----------------
You should create one R script called `run_analysis.R` that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R
-----------------
High level overview of the steps `run_analysis.R` performs...

1. The script downloads and unzips the UCI HAR Dataset dataset to the working directrory.
2. It then combines the test and train data into one list. 
3. It then combines the test and train data labels into one list.
4. It then combines the test and train subjects into one list.
5. It then combines the test and train features (measurements) into one list.
6. It then pulls out only *mean* and *standard deviation* measurements.
7. It then cleans up the variable names.
8. It then reads in and cleans up the activity names.
9. It then replaces the activity id with the human readable activity name.
10. It then combines the lists (subjects, test & train data, test & train data labels) and writes the result as to a CSV in the working directory (`combinedData.csv`).
11. It then creates a new data frame that contains averages of all the variables and writes the result to a CSV in the working directory (`averagedData.csv`).