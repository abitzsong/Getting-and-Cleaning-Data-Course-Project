library(dplyr)
library(readr)

##First part of the script
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileDIR <- "./rawfiles"

download.file(fileURL, destfile = "./Dataset.zip")
unzip("./Dataset.zip",exdir = fileDIR)

##Second part of the script
#Features
features <- read_table2("rawfiles/UCI HAR Dataset/features.txt", col_names = FALSE)
colnames(features) <- c("activityNumber","activityNames")
#activity labels
activity_labels <- read_table2("rawfiles/UCI HAR Dataset/activity_labels.txt", col_names = FALSE)

#test data
subject_test <- read_table2("rawfiles/UCI HAR Dataset/test/subject_test.txt",col_names = FALSE)
colnames(subject_test) <- "subject"
X_test <- read_table2("rawfiles/UCI HAR Dataset/test/X_test.txt",col_names = FALSE)
y_test <- read_table2("rawfiles/UCI HAR Dataset/test/y_test.txt",col_names = FALSE)
colnames(y_test) <- "labels"
testDATA <- cbind(subject_test,y_test,X_test)

#train data
subject_train <- read_table2("rawfiles/UCI HAR Dataset/train/subject_train.txt",col_names = FALSE)
colnames(subject_train) <- "subject"
X_train <- read_table2("rawfiles/UCI HAR Dataset/train/X_train.txt",col_names = FALSE)
y_train <- read_table2("rawfiles/UCI HAR Dataset/train/y_train.txt",col_names = FALSE)
colnames(y_train) <- "labels"
trainDATA <- cbind(subject_train,y_train,X_train)

#combine two data sets
DATA <- rbind(testDATA,trainDATA)
colnames(DATA) <- c("subject","labels",features$activityNames)


##Third part of the script
#select only column for the measurements on the mean and standard deviation
select.colnames <- grep("mean\\(\\)|std\\(\\)",colnames(DATA),value = TRUE)

#select columns for DATA
DATAselected <- select(DATA,subject,labels,select.colnames)

#Uses descriptive activity names to name the activities
descriptiveLabels <- activity_labels$X2
DATAselected$labels <- as.factor(DATAselected$labels)
levels(DATAselected$labels) <- descriptiveLabels
DATAselected <- as_tibble(DATAselected)
## DATAselected is the dataset asked for in step 4

##Forth part of the script
#creating a tidy dataset with the average of each variable for each activity and each subject
library(reshape2)
DATAmelted <- melt(DATAselected,c("labels","subject"),measure.vars = select.colnames, value.name = "value")
DATAtidy <- dcast(DATAmelted, labels + subject ~ variable, mean)

#creating a txt tidy dataset for submission
DATAtidy2 <- arrange(DATAtidy,labels,subject)
write.table(DATAtidy2,file="./tidyData.txt",sep=" ",row.name=FALSE)
