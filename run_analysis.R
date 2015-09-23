#Read and merge related test and train files
mergedFeatures <- rbind(read.table("../rdata/train/X_train.txt"),read.table("../rdata/test/X_test.txt"))
mergedActivity <- rbind(read.table("../rdata/train/Y_train.txt"),read.table("../rdata/test/Y_test.txt"))
mergedSubject <- rbind(read.table("../rdata/train/subject_train.txt"),read.table("../rdata/test/subject_test.txt"))

#assign names to columns
names(mergedSubject) <- c("Subject")
names(mergedActivity) <- c("Activity")
featureNames <- read.table("features.txt")
names(mergedFeatures) <- featureNames$V2

#Merge Subject and Activity as columns
SubAct <- cbind(mergedSubject, mergedActivity)

#put SubAct columns as additional columns on mergedFeatures
completeData <- cbind(mergedFeatures, SubAct)

#select only names with mean() or std() in them
sfeatureNames <- featureNames$V2[grep("mean\\(\\)|std\\(\\)",featureNames$V2)]
filteredNames <- c(as.character(sfeatureNames),"Subject","Activity")

#use the filtered name list to subset the complete data set
selectedData <- subset(completeData, select=filteredNames)

#Get the names of the activities
actLabels <- read.table("activity_labels.txt")

#change numbers to Labels for activities
selectedData$Activity <- actLabels[,2][match(selectedData$Activity,actLabels[,1])]

#change labels in data set so they are descriptive
names(selectedData) <- gsub("^t", "time", names(selectedData))
names(selectedData) <- gsub("^f", "frequency", names(selectedData))
names(selectedData) <- gsub("Acc", "Accelerometer", names(selectedData))
names(selectedData) <- gsub("Gyro", "Gyroscope", names(selectedData))
names(selectedData) <- gsub("Mag", "Magnitude", names(selectedData))
names(selectedData) <- gsub("BodyBody", "Body", names(selectedData))

#create a new tidy data set
#contains only the average of each variable for each activity and subject
library(plyr)
selectedData2 <- aggregate(. ~Subject + Activity, selectedData, mean)
selectedData2 <- selectedData2[order(selectedData2$Subject,selectedData2$Activity),]

#write the table out to a new tidy data file
write.table(selectedData2, file="ProjectTidyData.txt",row.name=FALSE)



