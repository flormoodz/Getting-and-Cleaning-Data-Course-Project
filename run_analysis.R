# Pre-analysis 
## 1 Prepare the dataset
fileName <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

## 2 Download file
if(!file.exists(fileName)){
  download.file(url,fileName, mode = "wb") 
}

## 3 Unzip file
if(!file.exists(dir)){
  unzip("UCIdata.zip", files = NULL, exdir=".")
}

## 4 Read Data
### Read the subject IDs
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

### Read the features data
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")

### Read the activities data
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

### Read the labels of features and activities
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  



# Analysis Proper
## 1 Merge the training and the test sets to create one data set
### Concatenate data by rows
DataSubject <- rbind(subject_train, subject_test)
DataActivity<- rbind(y_train, y_test)
DataFeatures<- rbind(x_train, x_test)

### Set names to variables
names(DataSubject)<- c("subject")
names(DataActivity)<- c("activity")
names(DataFeatures)<- features$V2

### Concatenate data by column
Data <- cbind(DataFeatures, DataSubject, DataActivity)


## 2 Extract only the measurements on the mean and standard deviation 
##      for each measurement
### Subset Names of Features on the mean and standard deviation
SubDataFeatureNames <-names(DataFeatures)[grep("mean()|std()", features[, 2]) ]

### Subset Data frame by selected names of Features
SelectedNames <- c(as.character(SubDataFeatureNames), "subject", "activity" )
Data<- subset(Data,select=SelectedNames)


## 3 Use descriptive activity names to name the activities in the 
##      data set
### Factor Activity in the Data Frame using Descriptive Names
act_group <- factor(Data$activity)
levels(act_group) <- activity_labels[,2]
Data$activity <- act_group

### Check
head(Data$activity)


## 4 Appropriately label the data set with descriptive variable names
### Rename Feature labels (since already done with Subject and Activity Variables)
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

### Check
names(Data)


## 5 From the data set in step 4, creates a second, independent tidy 
##      data set with the average of each variable for each 
##      activity and each subject.
library(plyr)
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidy_data.txt",row.names=FALSE)
