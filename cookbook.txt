Getting-and-Cleaning-Data
=========================
run_analysis.R will do the following:
1. Merges the training and the test sets to create one data set.
joinData contains training & test data of x 
joinActivity contains training & test data of y
joinSubject contains training & test data of subject

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
use "grep" to extract the measurements on mean & std
use "gsub" to tidy up the names 

3. Uses descriptive activity names to name the activities in the data set
read activity names from "activity_labels.txt" and map them to joinActivity

4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
create a new dataset with first 2 columns as subjects & activities. The rest of the columns are average of each variable for each activity and each subject respectively.
