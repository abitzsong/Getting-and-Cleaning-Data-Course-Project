# Getting-and-Cleaning-Data-Course-Project
Getting and Cleaning Data Course Project

- What the script does
This scipt was coded for Coursera-Getting and Cleaning Data Course Project.

- The first part of the script: 
Downloads the raw data files and unzip it into working directory.

- The second part of the script: 
Reads those raw txt data into R dataframes for manilulation, and combines those dataframes into one main datasets.

- The third part of the script: 
Selects the columns for the measurements on the mean and standard deviation and constructs the dataframe as demanded (3. Uses descriptive activity names to name the activities in the data set; 4. Appropriately labels the data set with descriptive variable names.), using package dplyr.

- The fourth part of the script: 
Creates the tidy dataset demended (an independent tidy data set with the average of each variable for each activity and each subject), using package reshape2.

#Codebook for tidyData
- labels: 
factor, with 6 levels: 
"WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" 
"SITTING" "STANDING" "LAYING"

- subject: 
character, as the raw data codebook.

- variables including "mean()" and "std()": 
The "average" of those variables in the raw dataset.
