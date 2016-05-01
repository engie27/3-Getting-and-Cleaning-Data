#Get the UCI HAR Dataset
if (!file.info('UCI HAR Dataset')$isdir) {
    dataFile <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
    dir.create('UCI HAR Dataset')
    download.file(dataFile, 'UCI-HAR-dataset.zip', method='curl')
    unzip('./UCI-HAR-dataset.zip')
    print("The UCI HAR Dataset has been downloaded and unzipped to your working directory.")
}else{
    print("the UCI HAR Dataset is already present in your working directory.")
}

print("Reading in test and train data")
#Combine test and training data
x <- rbind(read.table('./UCI HAR Dataset/train/X_train.txt'), read.table('./UCI HAR Dataset/test/X_test.txt'))

print("Reading in test and train data labels")
#Combine the test and training data labels
y <- rbind(read.table('./UCI HAR Dataset/train/y_train.txt'), read.table('./UCI HAR Dataset/test/y_test.txt'))

print("Reading in test and train subjects")
#Combine test and training subjects data
subjects <- rbind(read.table('./UCI HAR Dataset/train/subject_train.txt'), read.table('./UCI HAR Dataset/test/subject_test.txt'))

print("Retriving only Mean and Standard Deviation measurements")
#Get only mean and standard deviation measurements
features <- read.table('./UCI HAR Dataset/features.txt')
meanStdDevFeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
#x data only selecting mean and std dev columns
xMeanStdDev <- x[, meanStdDevFeatures]

print("Getting activity labels")
#Read activity labels from file
activities <- read.table('./UCI HAR Dataset/activity_labels.txt')

print("Cleaning up measurement and activity names")
#Feature name clean up
#Start with features
names(xMeanStdDev) <- features[meanStdDev,2]
names(xMeanStdDev) <- tolower(names(xMeanStdDev))
#lose the parentheses
names(xMeanStdDev) <- gsub("\\(\\)", "", names(xMeanStdDev))
#Time for activities
activities[, 2] <- tolower(as.character(activities[, 2]))
activities[, 2] <- gsub("_", "", activities[, 2])

#replace activity id with activity text and add column names to y and subjects
y[, 1] <- activities[y[, 1], 2]
colnames(y) <- 'activity'
colnames(subjects) <- 'subject'

print("Combining subject, data and data labels lists into one list and writing the list to CSV")
#combine disperate lists into one list and write the file
data <- cbind(subjects, xMeanStdDev, y)
write.txt(data, './combinedData.txt', row.names = FALSE)

print("Creating a tidy data set of variable averages and writing to CSV")
#create a second, independent tidy data set with the average of each variable for each activity and each subject.
average <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
#remove duplicated columns
average <- average[, !(colnames(average.df) %in% c("subj", "activity"))]
write.table(average, './averagedData.txt', row.names = FALSE)

print (paste("Done, CSVs 'combinedData.txt' and 'averagedData.txt' have been created in",getwd()))




