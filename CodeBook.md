CodeBook from Getting and Cleaning Data
==========================
I already put the folder of the data in the repository (UCI HAR Dataset)

Run_analysis.R Opens the data and creates 2 tidy datas according to instructions.
+ The R script File is completely commented so you can read the file or the CodeBook

1. First Step: Merges the training and the test sets to create one data set.
According to README.txt in UCI HAR Dataset we have:
 - 'train/X_train.txt': Training set.
 - 'test/X_test.txt':   Test set.
 - So we have to merge mXtest and mXtrain from Script file

* 2.  Reads file features.txt and extracts only the measurements on the mean and standard deviation
+	for each measurement.
+	
+	The result is a 10299 x 66 data frame, because only 66 out of 561 attributes are
+	measurements on the mean and standard deviation.
+	All measurements appear to be floating point numbers in the range (-1, 1).
+	
+	* 3. Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:
+	
* walking
* walkingupstairs
*	walkingdownstairs
*	sitting
*	standing
*	laying
	
	* 4. The script also appropriately labels the data set with descriptive names:
	all feature names (attributes) and activity names are converted to lower case,
	underscores and brackets () are removed.

+	Then it merges the 10299x66 data frame containing features with
	10299x1 data frames containing activity labels and subject IDs.

+	The result is saved as merged_clean_data.txt, a 10299x68 data frame
	such that the first column contains subject IDs,
	the second column activity names,
	and the last 66 columns are measurements.
	Subject IDs are integers between 1 and 30 inclusive.
	Names of the attributes are similar to the following:
	
*	tbodyacc-mean-x 
*	tbodyacc-mean-y 
*	tbodyacc-mean-z 
*	tbodyacc-std-x 
*	tbodyacc-std-y 
*	tbodyacc-std-z 
*	tgravityacc-mean-x 
*	tgravityacc-mean-y
	
* 5. Finally, the script creates a 2nd, independent tidy data set with the average
 of each measurement for each activity and each subject.
	
+	The result is saved as data_set_with_the_averages.txt, a 180x68 data frame, where as before,
	the first column contains subject IDs, the second column contains activity names (see below),
	and then the averages for each of the 66 attributes are in columns 3...68.
	There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
