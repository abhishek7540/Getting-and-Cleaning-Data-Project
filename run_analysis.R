#Loading necessary R Packages
library(dplyr)

#Reading the test data
x_test <- read.table("./UCI HAR Dataset/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/y_test.txt")
sub_test <- read.table("./UCI HAR Dataset/subject_test.txt")

#Reading the train data
x_train <- read.table("./UCI HAR Dataset/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/y_train.txt")
sub_train <- read.table("./UCI HAR Dataset/subject_train.txt")

#Reading the features and activity labels
var_names <- read.table("./UCI HAR Dataset/features.txt")
act_lab <- read.table("./UCI HAR Dataset/activity_labels.txt")

#1: Merges the training and the test sets to create one data set
x_total <- rbind(x_train, x_test)
y_total <- rbind(y_train, y_test)
sub_total <- rbind(sub_test, sub_train)

#2: Extracts only the measurements on the mean and standard deviation for each measurement
selected_var <- var_names[grep("mean\\(\\)|std\\(\\)", var_names[ , 2]), ] 
x_total_mod <- x_total[ , selected_var[ , 1]]

#3: Uses descriptive activity names to name the activities in the data set
y_total_mod <- left_join(y_total, act_lab, by = "V1")
colnames(y_total_mod) <- c("Activity", "Description")

#4: Appropriately labels the data set with descriptive variable names
colnames(x_total_mod) <- var_names[selected_var[ , 1], 2]

#5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
sub_total_mod <- left_join(sub_total, act_lab, by = "V1")
colnames(sub_total_mod) <- c("Activity", "Description")
total <- cbind(x_total_mod, sub_total_mod)
total_mean <- total %>% group_by(Description) %>% summarise_each(funs(mean))

#Output Table
write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)