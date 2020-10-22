---
title: "CodeBook"
author: "FlorMoodz"
date: "10/22/2020"
output:
  html_document: default
  pdf_document: default
---


# Code Book
This describes the variables, the data, and any transformations or work that was performed to clean up the data. 


## Brief Background on the Data Set 
The data is collected from the accelerometers from the Samsung Galaxy S smartphone. The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 

The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the *training data* and 30% the *test data*. 

The [full description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) are available for viewing and downloading.


## The Variables
-  `subject_test`: subject IDs for test

-  `subject_train`: subject IDs for train

-  `X_test`: values of variables in test

-  `X_train`: values of variables in train

-  `y_test`: activity ID in test

-  `y_train`: activity ID in train

-  `activity_labels`: description of activity IDs in y_test and y_train

-  `features`: description(label) of each variables in X_test and X_train


## Steps Made to Clean the Data
### A. Pre-Analysis
1. Prepare dataset

2. Download data files

3. Unzip data files

4. Read data
    -  Read the subject IDs
    -  Read the features data
    -  Read the activities data
    -  Read the labels of features and activities


### B. Analysis Proper
1. Merge the training and the test sets to create one data set
    -  Concatenate data by rows
    -  Set names to variables
    -  Concatenate data by column
    
    
2. Extract only mean() and std()
    -  Subset Names of Features on the mean and standard deviation
    -  Subset Data frame by selected names of Features
    
    
3. Assign Descriptive Activity Names
    -  Factor Activity in the Data Frame using Descriptive Names
    
    
4. Label the data set with descriptive variable names
    -  Rename Feature labels (since already done with Subject and Activity Variables):
        -  prefix t is replaced by time
        -  Acc is replaced by Accelerometer
        -  Gyro is replaced by Gyroscope
        -  prefix f is replaced by frequency
        -  Mag is replaced by Magnitude
        -  BodyBody is replaced by Body
    
    
5. Create Independent Tidy Data set
    -  Used plyr package
    -  write.table() with `row.names=FALSE`

