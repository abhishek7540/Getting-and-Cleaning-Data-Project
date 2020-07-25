Getting-and-Cleaning-Data-Project
Project for Submission


NOTE: After pulling ALL the files from the repository, you will find two zip files in 'UCI HAR Dataset' namely- X_test.zip and X_train.zip. 
      This has been done due to the cap on the size of the file that can be uploaded on the github repository.
      

CODE SUMMARY:
1. Installing and loading the dplyr package, which will be used for running the intire code.

2. Since there are two zip files present in 'UCI HAR Dataset' in addition to the other .txt files, unzip command will be used to extract the text files to the same folder. Before proceeding, plase check if you have the following .txt files available in the 'UCI HAR Dataset' folder:
  a. activity_labels.txt - Activity labels along with the identifying code for the Y datasets
  b. features.txt - defining the variable names in the X datasets
  c. features_info.txt - Shows information about the variables used on the feature vector
  d. README.txt - Overall information about the various datasets
  e. subject_test.txt/subject_train.txt - Test and train datsets for subjects
  f. X_test.txt/X_train.txt - Test and train datasets for X
  g. y_test.txt/y_train.txt - Test and train datsets for Y
  
3. The next step is to read the above mentioned datasets in the appropriate format and renaming the column names of the X, Y and Subject datasets with     the activity and feature names.

4. The first task is to merge the test and training datasets into single dataset for X and Y respectively. Additionally, we'll also merge the subject      data into a single dataset. We'll further combine all three datasets to create 'mdata'.

5. The second task is to extract only those variables containing 'mean' or 'std' in their variable names and create a subset of mdata, called 'tdata'.

6. In order to create a tidy dataset, it is important to have descriptive variable names and removing any non-alphabetical characters from the variable    names.

7. The final step is to summarise the data set across each subject and activity using mean as a descriptive statistic. The output of this summary is then saved as a new table titled 'tidydata.txt'. 