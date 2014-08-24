##sets working dir to current dir
setwd(".")
##creates a data dir to be used as the working dir
if (!file.exists("data")) { dir.create("data") }
## downloads the zip file containing the source data
fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile=".\\data\\UCI_HAR_Dataset.zip")
dateDownloaded = date()
dateDownloaded

## unzip source data to start working
unzip(".\\data\\UCI_HAR_Dataset.zip", exdir=".\\data")

## Load master data sets (activity labels, features), and set col names
activityLabelsData = read.table(".\\data\\UCI HAR Dataset\\activity_labels.txt",col.names=c("activityId","activityName"))
featuresData = read.table(".\\data\\UCI HAR Dataset\\features.txt",col.names=c("featureId","featureName"))

## Load Train data sets, and set column names
## Appropriately labels the data set with descriptive variable names.
subjectTrainData = read.table(".\\data\\UCI HAR Dataset\\train\\subject_train.txt",col.names=c("subjectId"))
xTrainData = read.table(".\\data\\UCI HAR Dataset\\train\\X_train.txt",col.names=featuresData$featureName)
yTrainData = read.table(".\\data\\UCI HAR Dataset\\train\\y_train.txt",col.names=c("activityId"))

## Create full train data set
trainData = cbind(subjectTrainData, yTrainData, xTrainData)

## Load Test data sets, and set column names
## Appropriately labels the data set with descriptive variable names.
ubjectTestData = read.table(".\\data\\UCI HAR Dataset\\test\\subject_test.txt",col.names=c("subjectId"))
xTestData = read.table(".\\data\\UCI HAR Dataset\\test\\X_test.txt",col.names=featuresData$featureName)
yTestData = read.table(".\\data\\UCI HAR Dataset\\test\\y_test.txt",col.names=c("activityId"))

## Create full test data set 
testData = cbind(subjectTestData, yTestData, xTestData)

##Append test data set to the train data set
## STEP 1. Merges the training and the test sets to create one data set.
allData = rbind(trainData,testData)

##get col names for mean measurements
colNamesMean = grep("\\.mean\\.",names(allData),value=TRUE)
##get col names for std measurements
colNamesStd = grep("\\.std\\.",names(allData),value=TRUE)

##create a subset data set with the required columns only to operate with
## STEP 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
opData = subset(allData, select=c("subjectId","activityId",colNamesMean,colNamesStd))

##Data set with activity descriptions - labelName column
## STEP 3. Uses descriptive activity names to name the activities in the data set 
opActNameData = merge(opData, activityLabelsData, by="activityId")

## STEP 4. Appropriately labels the data set with descriptive variable names.
## This is already done. Execute following command to check.
names(opActNameData)

## STEP 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData = aggregate(opActNameData[setdiff(names(opActNameData),c("subjectId", "activityName","activityId"))], by=opActNameData[c("subjectId", "activityName")], FUN=mean)
## Output a txt file with the tidy dataset as described on STEP 5
write.table(tidyData, file=".\\data\\tidyDataset.txt", row.names=FALSE)

