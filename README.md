# CourseProject

##Getting and Cleaning Data Project


###Script description

Download data from this website:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the data set. Unzipped, data are in the folder UCIHARDataset in the set working directory.


###Running run_analysis.R script

Script uses packages dplyr, tidyr, reshape2.

Data is first loaded ad read using read.table().

The names of the columns are set using names().

Then it performs Task 1 from the assignment: Merge the training and the test sets to create one data set. Training and test data sets are merged using cbind() and then rbind() into a joind data set.

Task 2 is then performed: Extract only the measurements on the mean and standard deviation for each measurement using select(), matches() and contains(). Data set has 33 different kinds of signals, measured or derived, and only Mean and Standard Deviation need to be considered.

Then it performs Task 3: Use descriptive activity names to name the activities in the data set and Task 4: Appropriately labels the data set with descriptive variable names, using factor() levels(), gsub(), names() melt() group_by(). The names set are Domain, Component, Signal, Statistic (either the Mean or the Standard Deviation (Std), Direction; and they are described in codebook.

Finally, it performs Task 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject, using spread() and write.table() with row.names=FALSE.
The output is clean data set in a text file, Tidy_Data_Set.txt, in the working directory.



