# run_analysis.R
===================
## The run_analysis.R performs the following activities 

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### The script first sets the working directory as specified by the user as the Present Working directory where the data set is present . It then sets the filepath to initialize the various files . Once done , it initialized the variable (STUDY_DATA ) which holds the consolidated data for training and test data. It then imports the training and testing data and consolidates it under the STUDY_DATA variable.

### The script then imports the heading data under the variable STUDY_DATA_COLUMN_HEADINGS. It replaces hyphens(-),comma(,),brackets (()) and period(.) with underscore(_) and  then renames the column headings for master data set (STUDY_DATA) 

### The script then extracts the data for the Mean and Standard deviations and stores is under variable MEAN_AND_SD_STUDY_DATA

### The script then reads the activity labels and assign them to the activity codes . The data STUDY_DATA_WITH_ACTIVITY_LABELS stores the data with activity labels

### The script finally creates a query to extract the mean of all columns grouping them by Activity and Test Subject and store it under the data set TINY_DATA
