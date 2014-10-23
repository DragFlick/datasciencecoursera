
        

        # PROVIDE THE FILEPATH FOR THE DATASET IN THE ABSOLUTE_FILEPATH VARIABLE. IF NOT , YOU CAN SET THE 
        # WORKING DIRECTORY TO THE FOLDER "UCI HAR Dataset" AND COMMENT OUT THE SECTION HELD BETWEEN THE 2
        # HASH TAG LINES . ELSE PROVIDE THE ABSOLUTE PATH TO THE "UCI HAR Dataset" AND THE SCRIPT CAN SET 
        # THE DATA PATH ITSELF

        ###############################################################################################

        ABSOLUTE_FILEPATH = "C:/CHITRESH - DUMPS/COURSEERA - DATA SCIENTIST TOOLBOX/COURSERA - Getting and Cleaning Data/UCI HAR Dataset"  
        
        
        # SETTING UP THE WORKING DIRECTORY
        setwd(ABSOLUTE_FILEPATH) 
        
        ################################################################################################

        # INSTALLING NECESSARY PACKAGES AND LOADING THEM IN LIBRARY
        
        library(sqldf)
        
        

        
      
        
        # STORING THE REQUIRED FILE PATH DETAILS IN VARIABLES
        
        TEST_DATA_FILEPATH <- "./test/X_test.txt" 
        TRAINING_DATA_FILEPATH <- "./train/X_train.txt"
        TEST_SUBJECT_FILEPATH <- "./test/subject_test.txt"
        TRAINING_SUBJECT_FILEPATH <- "./train/subject_train.txt"
        TEST_ACTIVITY_FILEPATH <- "./test/y_test.txt"
        TRAINING_ACTIVITY_FILEPATH <- "./train/y_train.txt"
        FEATURE_DETAILS_FILEPATH <- "./features.txt"
        ACTIVITY_LABELS_FILEPATH <- "./activity_labels.txt"
        
        
        
        #INITIALIZING THE FINAL STUDY DATA WHICH WILL HOLD THE TEST AND TRAINING DATA
        STUDY_DATA <- data.frame()
        
        
        
        #MERGING TEST DATA SET INTO THE STUDY DATA 
        
        ## Importing test data
        
        test_data <- read.table(TEST_DATA_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("numeric"))
        
        ## Importing the test subejct data and test activity data  
        
        test_subject_data <- read.table(TEST_SUBJECT_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("integer"))
        test_activity_data <- read.table(TEST_ACTIVITY_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("integer")) 
       
        
        ## Merged the subject and activity data with the test data.
        
        test_data <- cbind(test_subject_data,test_data)
        test_data <- cbind (test_activity_data,test_data)
        

        ## Consolidating test data into STUDY_DATA
        
        STUDY_DATA <- rbind(STUDY_DATA,test_data)
        

        
        
        # MERGING TRAINING DATA SET INTO THE STUDY DATA
        
        
        ## Importing the training data 
        
        training_data <- read.table(TRAINING_DATA_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("numeric"))
        
        
        ## Importing the test subject and training activity data
        
        training_subject_data <- read.table(TRAINING_SUBJECT_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("integer"))
        training_activity_data <- read.table(TRAINING_ACTIVITY_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("integer")) 
       
        
        ## Merged the activity data and subject data with the training activity data
        
        
        training_data <- cbind(training_subject_data,training_data)        
        training_data <- cbind(training_activity_data,training_data)
        
        ## Combined the training dataset into the study data set 
        
        ## STUDY_DATA is the combined dataset which consists of training as well as test data set.
        
        STUDY_DATA <- rbind(STUDY_DATA,training_data)
        
        
        
        # CLEANING UP THE HEADING DATA
        
        
        ## Reading the feature details , cleaning them and peparing the column headings
        
        
        column_headings <- read.table(FEATURE_DETAILS_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("integer","character"))
        
        ## Assigning the column names to the column headings 
        
        names(column_headings) <- c("serialnumber","colheading")
        
        ## Correcting the bracket mismatch in one of the records 
        
        # column_headings$colheading[556] <- "angle(tBodyAccJerkMean_gravityMean)"
        
        ## Replacing Open and Close brackets (()) , period (.),comma(,) and hyphen(-) sign with underscore (_) and converting the names to lowercase 
        
        column_headings$colheading <- tolower(column_headings$colheading)
        column_headings$colheading <- gsub("\\.","",column_headings$colheading)
        column_headings$colheading <- gsub("\\(\\)","",column_headings$colheading)
        column_headings$colheading <- gsub("-","_",column_headings$colheading)
        column_headings$colheading <- gsub("\\,","_",column_headings$colheading)
        column_headings$colheading <- gsub("\\(","_",column_headings$colheading)
        column_headings$colheading <- gsub("\\)","_",column_headings$colheading)
        
     
        ## Creating the column headings for the master data set "STUDY_DATA"
        
        STUDY_DATA_COLUMN_HEADINGS <- c("activity_id","subject_id",column_headings$colheading)
        
        
        ## Merging the header data to the Study Data 
        
        
        names(STUDY_DATA) <- STUDY_DATA_COLUMN_HEADINGS
        
        # EXTRACTING THE DATA FOR MEAN AND STANDARD DEVIATION FROM THE MASTER DATA SET
        
        MEAN_AND_SD_STUDY_DATA <- STUDY_DATA[,3:8]
        
       
        # ASSIGNING DESCRIPTIVE ACTIVITY LABELS TO ACTIVITY CODES
        
        
        ## Reading activity labels from ACTIVITY_LABELS_FILEPATH file  
        
        ACTIVITY_LABELS <- read.table(ACTIVITY_LABELS_FILEPATH,numerals  = "no.loss",strip.white = TRUE,colClasses = c("integer","character"))
        
        ## Assigning names to columns in Activity Label data frame.
        names(ACTIVITY_LABELS) <- c("activity_id","activity_labels")        
        
        ## Joining label data with study data and formatting it accordingly
        STUDY_DATA_WITH_ACTIVITY_LABELS <- sqldf("select STUDY_DATA.* , ACTIVITY_LABELS.activity_labels from STUDY_DATA join ACTIVITY_LABELS using (activity_id)")
        STUDY_DATA_WITH_ACTIVITY_LABELS <- STUDY_DATA_WITH_ACTIVITY_LABELS[,c(1,2,564,3:563)]
        
        # EXTRACTING THE MEAN DATA 
        ## Preparing Query to extract the mean data. Storing the name data for data frame STUDY_DATA and then preparing the required SELECT query
        ## prepare 
        
        heading <- names(STUDY_DATA)
        
        query <- paste ("select activity_id, subject_id , ","avg","(",heading[3],")"  ,sep = "",collapse = NULL)
        for ( count in 4:length(heading))
        {
                temp <- paste("avg","(",heading[count],")", sep = "",collapse = NULL)
                query <- paste(query ,temp , sep = ",",collapse = NULL)
                
        }
        
        query <- paste(query,"from STUDY_DATA group by activity_id, subject_id order by activity_id, subject_id ")
        
        ## Firing the query to prepare tidy data set (TIDY_DATA) from the STUDY_DATA
        
        TIDY_DATA <- sqldf(query)
        


