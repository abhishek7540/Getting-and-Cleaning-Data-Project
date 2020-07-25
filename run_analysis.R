#Please pull ALL THE FILES present in the repository before running this code

#Installing and loading necessary R Packages
install.packages("dplyr")
library(dplyr)

#Unzip the X test and train files
unzip(zipfile = "./UCI HAR Dataset/X_test.zip", exdir = "./UCI HAR Dataset")
unzip(zipfile = "./UCI HAR Dataset/X_train.zip", exdir = "./UCI HAR Dataset")

#Reading the features and activity labels
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("Code", "Funcion"))
activity_labels<- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ID", "Activity"))

#Reading the test data
x_test <- read.table("./UCI HAR Dataset/X_test.txt", col.names = features$Funcion)
y_test <- read.table("./UCI HAR Dataset/y_test.txt", col.names = "ID")
sub_test <- read.table("./UCI HAR Dataset/subject_test.txt", col.names = "Subject")

#Reading the train data
x_train <- read.table("./UCI HAR Dataset/X_train.txt", col.names = features$Funcion)
y_train <- read.table("./UCI HAR Dataset/y_train.txt", col.names = "ID")
sub_train <- read.table("./UCI HAR Dataset/subject_train.txt", col.names = "Subject")

  

#1: Merges the training and the test sets to create one data set
x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)
sub_total <- rbind(sub_test, sub_train)
mdata <- cbind(sub_total, x_total, y_total)

#2: Extracts only the measurements on the mean and standard deviation for each measurement
tdata <- mdata %>% select(Subject, ID, contains("mean"), contains("std"))

#3: Uses descriptive activity names to name the activities in the data set
tdata$id <- activity_labels[tdata$ID, 2]

#4: Appropriately labels the data set with descriptive variable names
names(tdata)[2] = "Activity"
names(tdata)<-gsub("Acc", "Accelerometer", names(tdata))
names(tdata)<-gsub("Gyro", "Gyroscope", names(tdata))
names(tdata)<-gsub("BodyBody", "Body", names(tdata))
names(tdata)<-gsub("Mag", "Magnitude", names(tdata))
names(tdata)<-gsub("^t", "Time", names(tdata))
names(tdata)<-gsub("^f", "Frequency", names(tdata))
names(tdata)<-gsub("tBody", "TimeBody", names(tdata))
names(tdata)<-gsub("-mean()", "Mean", names(tdata), ignore.case = TRUE)
names(tdata)<-gsub("-std()", "STD", names(tdata), ignore.case = TRUE)
names(tdata)<-gsub("-freq()", "Frequency", names(tdata), ignore.case = TRUE)
names(tdata)<-gsub("angle", "Angle", names(tdata))
names(tdata)<-gsub("gravity", "Gravity", names(tdata))

#5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidydata <- tdata %>% group_by(Subject, Activity) %>% summarise_all(funs(mean)) %>% sort(Subject, Activity)

#Output Table
write.table(tidydata, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)