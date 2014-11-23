#1. Merges the training and the test sets to create one data set.
subject_test<-read.table("./test/subject_test.txt")
X_test<-read.table("./test/X_test.txt")
y_test<-read.table("./test/y_test.txt")

subject_train<-read.table("./train/subject_train.txt",)
X_train<-read.table("./train/X_train.txt")
y_train<-read.table("./train/y_train.txt")

joinData <- rbind(X_train, X_test)
joinActivity <- rbind(y_train,y_test)
joinSubject <- rbind(subject_train,subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
features<-read.table("features.txt")
index1 <- grep("mean\\(|std\\(", features[, 2])
joinData <- joinData[, index1]
names(joinData) <- gsub("\\(\\)|-", "", features[index1, 2]) 
names(joinData) <- gsub("mean", "Mean", names(joinData)) 
names(joinData) <- gsub("std", "Std", names(joinData)) 


# 3. Uses descriptive activity names to name the activities in the data set
activity<-read.table("activity_labels.txt")
activity[, 2] <- tolower( activity[, 2])
activityLabel <- activity[joinActivity[, 1], 2]
joinActivity[, 1] <- activityLabel
names(joinActivity) <- "Activity"

# 4. Appropriately labels the data set with descriptive variable names. 
names(joinSubject) <- "Subject"

cleanedData <- cbind(joinSubject, joinActivity,joinData)

# 5. creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1] 
columnLen <- dim(cleanedData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanedData)
row<-1
for (i in 1:subjectLen){
  for (j in 1:activityLen){
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    result[row, 3:columnLen] <- colMeans(cleanedData[(cleanedData$Subject == i & cleanedData$Activity == activity[j, 2]),3:columnLen])
    row <- row + 1    
  }
}
write.table(result,"./final_result.txt",row.name=FALSE)
