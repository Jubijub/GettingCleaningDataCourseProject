library(dplyr)

cleanup <- function(x) {
    x <- sub("\\(\\)","", x) #Remove parenthesis
    tolower(x) #lowercase names
}

## Download source data
sourceFile <- "./UCIDataset.zip"
destFolder <- "./rawdata"
rawdataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists(sourceFile)){download.file(rawdataURL,sourceFile)}
message("Source file successfully downloaded")

## Extract source data
if(!file.exists(destFolder)){dir.create(destFolder)}
if(file.exists(sourceFile)){unzip(zipfile=sourceFile, exdir=destFolder)}
if(file.exists("./rawdata/UCI HAR Dataset/README.txt")) {
    message("Data successfully retrieved from source file")
}

message("Assembling master data set...")
## Merging training and test activities
trainingData <- read.table("./rawdata/UCI HAR Dataset/train/X_train.txt")
trainingLabel <- read.table("./rawdata/UCI HAR Dataset/train/y_train.txt")
trainingSubjects <- read.table("./rawdata/UCI HAR Dataset/train/subject_train.txt")

testData <- read.table("./rawdata/UCI HAR Dataset/test/X_test.txt")
testLabel <- read.table("./rawdata/UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("./rawdata/UCI HAR Dataset/test/subject_test.txt")

measurements <- rbind(trainingData, testData)
measurementsLabel <- rbind(trainingLabel, testLabel)
measurementsSubjects <- rbind(trainingSubjects, testSubjects)

#cleanup
rm(trainingData, trainingLabel, trainingSubjects)
rm(testData, testLabel, testSubjects)

#Filter only on features containing mean/std
featuresRaw <- read.table("./rawdata/UCI HAR Dataset/features.txt")
featuresExpected <- grep(".*(std|mean).*", featuresRaw[,2])
measurements <- measurements[,featuresExpected]

#Get selected feature labels, and clean them
featuresLabels <- featuresRaw[featuresExpected,2]
featuresLabels <- sapply(featuresLabels, cleanup)

#apply features name to measurements
names(measurements) <- featuresLabels

#get and clean activity names
activitiesLabels <- read.table("./rawdata/UCI HAR Dataset/activity_labels.txt")
activitiesLabels <- sapply(activitiesLabels, cleanup) #clean the name (lowercase)

#replace activity codes with their real value, and assign a clean title
measurementsLabel[,1] <- activitiesLabels[measurementsLabel[,1],2]
names(measurementsLabel) <- "activity"
names(measurementsSubjects) <- "subject"

#assemble final dataset
cleandata <- cbind(measurementsSubjects, measurementsLabel, measurements)
cleandata <- arrange(cleandata, subject, activity)

message("Master dataset assembled and cleaned")

#produce summary independant tidy dataset with average per subject per activity
independant <- cleandata %>%
                group_by(subject, activity) %>%
                summarise_each(funs("mean", mean, mean(., na.rm = TRUE)))

write.table(independant, "averaged_data.txt", row.names = FALSE, quote = FALSE)
message("Summary dataset produced and cleaned : check 'averaged_data.txt'")
