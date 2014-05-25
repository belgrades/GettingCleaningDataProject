#Done by: Fernando Crema

mXtest <- read.table("UCI HAR Dataset\\test\\X_test.txt")
mXtrain <- read.table("UCI HAR Dataset\\train\\X_train.txt")
mSubjectTrain <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
mSubjectTest <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
mYtrain <- read.table("UCI HAR Dataset\\train\\y_train.txt")
mYtest <- read.table("UCI HAR Dataset\\test\\y_test.txt")
mfeatures <- read.table("UCI HAR Dataset\\features.txt")
mActivities <- read.table("UCI HAR Dataset\\activity_labels.txt")

#First Step: Merges the training and the test sets to create one data set.
#According to README.txt we have:
# - 'train/X_train.txt': Training set.
# - 'test/X_test.txt': Test set.
#So we have to merge mXtest and mXtrain

mXmerged <- rbind(mXtest, mXtrain)
mXmergedAll <- rbind(mXtest, mXtrain)

mSubject <- rbind(mSubjectTrain, mSubjectTest)

mYmerged <- rbind(mYtrain, mYtest)
mYmergedAll <- rbind(mYtrain, mYtest)
#Second Step: Extracts only the measurements on the mean and standard deviation for each measurement.

#Creating two boolean arrays with grepl function
#LogiMean will have TRUE if mean() is in the string for all columns 2 in features
logiMean<-grepl("mean()",mfeatures[,2],fixed=TRUE)

#LogiStd will have TRUE if std() is in the string for all columns 2 in features
logiStd<-grepl("std()",mfeatures[,2],fixed=TRUE)

#good_feature is the OR array from LogiMean and LogiStd
good_feature <- logiMean |logiStd

#Creating [1,2,3,...,561]
vec<-1:561

#Selecting vec[good_feature] (68 columns)
mXmerged <- mXmerged[, vec[good_feature]]

#Putting names in selected data and all data
names(mXmerged) <- mfeatures[vec[good_feature], 2]
names(mXmergedAll) <- mfeatures[vec, 2]

#Erasing () from std() and mean() sintax problems with names
names(mXmerged) <- gsub("\\(|\\)", "", names(mXmerged))
names(mXmergedAll) <- gsub("\\(|\\)", "", names(mXmergedAll))

#Step three: Uses descriptive activity names to name the activities in the data set

mYmerged[,1] = mActivities[mYmerged[,1], 2]
mYmergedAll[,1] = mActivities[mYmergedAll[,1], 2]

names(mYmerged) <- "activity"
names(mYmergedAll) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(mSubject) <- "subject"

#mAll because we need all variables not only mean and std
mAll <- cbind(mSubject,mYmergedAll,mXmergedAll)

#Creating tidy data #1
cleaned <- cbind(mSubject, mYmerged, mXmerged)
write.table(cleaned, "tidy_data_1.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

#Cleaning NA just in case =P
mAll <- mAll[complete.cases(mAll),]

uniqueSubjects = unique(mSubject)[,1]
mCols = dim(mAll)[2]

#We have 30 persons (subjects) and 6 activites per person so tidy average will have 180 rows
mAverage = mAll[1:180, ]
mDim = 3:mCols

i = 1

for (s in 1:30) {
  for (a in 1:6) {
    mAverage[i, 1] = uniqueSubjects[s]
    mAverage[i, 2] = mActivities[a, 2]
    mAverage[i, mDim] <- colMeans(mAll[mAll$subject==s & mAll$activity==mActivities[a, 2], ][, mDim])
    i = i+1
  }
}
write.table(result, "tidy_averages.txt")
