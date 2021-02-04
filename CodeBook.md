Getting and Cleaning Data - Final Project Code Book

1. DOWNLOAD THE ZIP FILE AND CONVERT ALL THE TEXT FILES REQUIRED FOR THE PROJECT INTO DATASETS.

Datasets Required
"activity_labels.txt" >> "acitivties"   (ROWS:6, COLUMNS:2)      #Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist.

"features.txt" >> "features"            (ROWS:561, COLUMNS:2)    #The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

"subject_train.txt" >> "subject_train"  (ROWS:7352, COLUMNS:1)   #Contains train data of 21/30 volunteer subjects being observed.

"subject_test.txt" >> "subject_test"    (ROWS:2947, COLUMNS:1)   #Contains test data of 9/30 volunteer test subjects being observed..
"X_train.txt" >> "x_train"              (ROWS:7352, COLUMNS:561) #Contains recorded features train data.
"X_test.txt" >> "x_test"                (ROWS:2947, COLUMNS:561) #Contains recorded features test data.
"y_train.txt" >> "y_train"              (ROWS:7352, COLUMNS:1)   #Contains train data of activities’code labels.
"y_test.txt" >> "y_test"                (ROWS:2947, COLUMNS:1)   #Contains test data of activities’code labels.

2. MERGE x_train, x_test, y_train, y_test, subject_train and subject_test DATASETS TO CREATE ONE DATASET.
"x" (10299 rows, 561 columns) is created by merging "x_train" and "x_test" using rbind() function
"y" (10299 rows, 1 column) is created by merging "y_train" and "y_test" using rbind() function
"subject" (10299 rows, 1 column) is created by merging "subject_train" and "subject_test" using rbind() function
"mergedData" (10299 rows, 563 column) is created by merging "subject", "x" and "y" using cbind() function

3. EXTRACT THE MEAN AND STANDARD DEVIATION OF EACH MEASUREMENT IN THE "mergedData" DATASET.
tidyData (10299 rows, 88 columns) is created by subsetting mergedData, selecting only columns: subject, S.No and the measurements on the mean and standard deviation (std) for each measurement

4. USE DESCRIPTIVE ACTIVITY NAMES TO NAME EACH ACTIVITY IN DATASET.
Entire numbers in "S.No" column of the TidyData replaced with corresponding activity taken from second column of the "activities" dataset

5. LABEL THE DATASET WITH DESCRIPTIVE VARIABLE NAMES.
"S.No" column in TidyData renamed into activity
All "Acc" in column’s name replaced by Accelerometer
All "Gyro" in column’s name replaced by Gyroscope
All "Mag" in column’s name replaced by Magnitude
All start with character f in column’s name replaced by Frequency
All start with character t in column’s name replaced by Time

5. CREATE A SECCOND, INDEPENDENT TIDY DATASET WITH AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
finalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export finalData into finalData.txt file.