The *run_analysis.R* script is used to collect, work with, and clean dataset to prepare tidy data. 

1. **Downloading Dataset**

    * Downloaded the Human Activity Recognition Using Smartphones Dataset and extracted under *UCI HAR Dataset* folder    



2. **Reading txt files and creating data frames**

    * features <- features.txt : 561 rows, 2 columns   
    The features selected for this database come from the accelerometer and gyroscope.
    
    * activity_labels <- activity_labels.txt : 6 rows, 2 columns    
    List of activities performed when the corresponding measurements were taken and its Id 
    
    * subject_train <- test/subject_train.txt : 7352 rows, 1 column    
    contains train data of volunteer subjects being observed 
    
    * X_train <- test/X_train.txt : 7352 rows, 561 columns 
    contains recorded features train data 
    
    * y_train <- test/y_train.txt : 7352 rows, 1 columns    
    contains train data of activities Id labels
    
    * subject_test <- test/subject_test.txt : 2947 rows, 1 column    
    contains test data of volunteer test subjects being observed
    
    * X_test <- test/X_test.txt : 2947 rows, 561 columns    
    contains recorded features test data
    
    * y_test <- test/y_test.txt : 2947 rows, 1 columns    
    contains test data of activities Id labels    
    
    
    
    
3. **Merges the training and the test sets to create one data set**

    * train_data (7352 rows, 563 colums) this data set is created by merging subject_train , y_train and X_train data frame using **data.frame** function
    
    * test_data (2947 rows, 563 colums) this data set is created by merging subject_test , y_test and X_test data frame using **data.frame** function
    
    * merged_data (10299 rows, 563 colums) this data set is created by merging train_data and test_data data frame using **rbind()** function       
    

   
4. **Extracts only the measurements on the mean and standard deviation for each measurement**

    * filtered_data (10299 rows, 88 columns) this data set is created by subsetting subject, activity and the measurements on the mean and standard deviation for each measurement from *merged_data* data frame.          
  


5. **Uses descriptive activity names to name the activities in the data set**

    * filtered_data$activity assigned activity names from *activity_labels* data set instead of activity ID in the *filerted_data* data set
    
    * tidy_data this data set created from *filtered_data* data set.        


6. **Appropriately labels the data set with descriptive variable names**

    * All *()* brackets in column's name replaced by empty string.
    * All start with character *t* in column's name replaced by *TimeDomain.*
    * All start with character *f* in column's name replaced by *FrequencyDomain.*
    * All *Acc* in column's name replaced by *Accelerometer*
    * All *Gyro* in column's name replaced by *Gyroscope*
    * All *Mag* in column's name replaced by *Magnitude*
    * All *BodyBody* in column's name replaced by *Body*
    * All *mean* in column's name replaced by *Mean*
    * All *std* in column's name replaced by *StandardDeviation*
    * All *freq* in column's name replaced by *Frequency*
    * All *angle* in column's name replaced by *Angle*
    * All *gravity* in column's name replaced by *Gravity*
    * All *..* in column's name replaced by empty string.        


7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**      

    * tidy_data (180 rows, 88 columns) is created with the average of each variable for each activity and each subject. 
    * Exported tidy_data into tidy_data.txt file.