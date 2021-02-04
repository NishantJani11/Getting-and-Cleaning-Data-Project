### Get the required packages for the project
library(dplyr)

### Download the zip file and unzip it after downloading
if(!file.exists("./data")) {dir.create("./data")}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data/get_clean_project.zip")
unzip("./data/get_clean_project.zip")

### Get all the text documents and convert them into dataframes [x(train, test), y(train, test), subject(train, test), features, activities]
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("S.No", "activity"))

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("No", "features"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("Subject"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$features)
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$features)

y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "S.No")

## STEP 1: MERGE THE TRAINING AND TESTING DATASETS
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
mergedData <- cbind(subject, x, y)

## STEP 2: EXTRACT THE MEAN AND STANDARD DEVIATION OF EACH MEASUREMENT IN MERGED DATASET
tidyData <- mergedData %>% select(subject, S.No, contains("Mean"), contains("std"))

## STEP 3: USE DESCRIPTIVE ACTIVITY NAMES TO NAME EACH ACTIVITY IN DATASET
tidyData$S.No <- activities[tidyData$S.No, 2]

## STEP 4: LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES
tidyData <- rename(tidyData, activity = S.No)
names(tidyData) <- gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) <- gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) <- gsub("Mag", "Magnitude", names(tidyData))
names(tidyData) <- gsub("^t", "Time", names(tidyData))
names(tidyData) <- gsub("^f", "Frequency", names(tidyData))
names(tidyData) <- gsub("tBody", "TimeBody", names(tidyData))

## STEP 5: CREATE A SECCOND, INDEPENDENT TIDY DATASET WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
finalData <- tidyData %>% group_by(subject, activity) %>% summarise_all(.funs = mean)

### Final Dataset
write.table(finalData, "finalData.txt", row.name=FALSE)