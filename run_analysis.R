library(plyr)
library(dplyr)
library(Hmisc)

## Downloading Dataset 

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL, destfile = "HAR_Dataset.zip")

if(file.exists("HAR_Dataset.zip")){
        unzip("HAR_Dataset.zip")
}


## Reading txt files and creating data frames 
        

features <- read.csv("UCI HAR Dataset/features.txt", header = FALSE, sep = "", col.names = c("Id", "functions"))

activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", col.names = c("Id","activity"))

X_train <- read.csv("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "", col.names = features$functions)

y_train <- read.csv("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep= "", col.names = "activity")

subject_train <- read.csv("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "", col.names = "subject")

train_data <- data.frame(subject_train, y_train, X_train)
 
X_test <- read.csv("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "", col.names = features$functions)

y_test <- read.csv("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep= "", col.names = "activity")

subject_test <- read.csv("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "", col.names = "subject")

test_data <- data.frame(subject_test, y_test, X_test)


## 1.	Merges the training and the test sets to create one data set.

merged_data <- rbind(train_data, test_data)


##2.	Extracts only the measurements on the mean and standard deviation for each measurement.

filtered_data <- select(merged_data, subject, activity, contains('mean'), contains('std'))


##3.	Uses descriptive activity names to name the activities in the data set

filtered_data$activity <- activity_labels[filtered_data$activity, "activity"]

tidy_data <- filtered_data


##4.	Appropriately labels the data set with descriptive variable names.


col_newLabel <- names(tidy_data)

col_newLabel <- gsub("[(][)]", "", col_newLabel)

col_newLabel <- gsub("^t","TimeDomain.", col_newLabel)

col_newLabel <- gsub("^f", "FrequencyDomain.", col_newLabel)

col_newLabel <- gsub("Acc", "Accelerometer", col_newLabel)

col_newLabel <- gsub("Gyro" , "Gyroscope", col_newLabel)

col_newLabel <- gsub("Mag", "Magnitude", col_newLabel)

col_newLabel <- gsub("BodyBody", "Body", col_newLabel)

col_newLabel <- gsub("mean", "Mean", col_newLabel)

col_newLabel <- gsub("std", "StandardDeviation", col_newLabel)

col_newLabel <- gsub("freq", "Frequency", col_newLabel)

col_newLabel <- gsub("angle", "Angle", col_newLabel)

col_newLabel <- gsub("gravity", "Gravity", col_newLabel)

col_newLabel <- gsub("\\.\\.", "", col_newLabel)

names(tidy_data) <- col_newLabel


##5. From the data set in step 4, creates a second, 
##independent tidy data set with the average of each variable for each activity and each subject.

tidy_data <- group_by(tidy_data, subject, activity) %>% summarize_all(funs(mean))

write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
