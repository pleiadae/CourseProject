library(dplyr)
library(tidyr)
library(reshape2)

setwd("/home/buca/R")

#loading data

xtrain <- read.table("UCIHARDataset/train/X_train.txt",nrows=7352) 
xtest <- read.table("UCIHARDataset/test/X_test.txt",nrows=7352)
ytrain <- read.table("UCIHARDataset/train/y_train.txt")
ytest <- read.table("UCIHARDataset/test/y_test.txt")
strain <- read.table("UCIHARDataset/train/subject_train.txt")
stest <- read.table("UCIHARDataset/test/subject_test.txt")
features <- read.table("UCIHARDataset/features.txt")
labels <- read.table("UCIHARDataset/activity_labels.txt")

#column names

names(xtest) <- features$V2
names(xtrain) <- features$V2
names(ytest) <- "Activity"
names(ytrain) <- "Activity"
names(stest) <- "Subject"
names(strain) <- "Subject"

#Task 1 - Merges the training and the test sets to create one data set.

trainset <- cbind (strain,ytrain,xtrain)
testset <- cbind (stest,ytest,xtest)
fullset <- rbind(testset,trainset)

#Task 2 - Extracts only the measurements on the mean and standard deviation for each measurement. 

names(fullset) <- make.names(names(fullset),unique=TRUE)
selectset <- select(fullset,matches("Subject"),matches("Activity"),contains("mean.."),contains("std")) %>% select(-contains("angle"))

#Task 3 - Uses descriptive activity names to name the activities in the data set

selectset$Activity <- factor(selectset$Activity)
levels(selectset$Activity) <- labels$V2

#Task 4 - Appropriately labels the data set with descriptive variable names. 

names(selectset) <- gsub("mean","Mean",names(selectset),fixed=TRUE)
names(selectset) <- gsub("std","Std",names(selectset),fixed=TRUE)
names(selectset) <- gsub("BodyBody","Body",names(selectset),fixed=TRUE)
names(selectset) <- gsub("..","",names(selectset),fixed=TRUE)
names(selectset) <- gsub(".","_",names(selectset),fixed=TRUE)
names(selectset) <- gsub("Mag_Mean","_Mean_Mag",names(selectset),fixed=TRUE)
names(selectset) <- gsub("Mag_Std","_Std_Mag",names(selectset),fixed=TRUE)
names(selectset) <- gsub("tBody","t_Body_",names(selectset),fixed=TRUE)
names(selectset) <- gsub("tGravity","t_Gravity_",names(selectset),fixed=TRUE)
names(selectset) <- gsub("fBody","f_Body_",names(selectset),fixed=TRUE)
longset <- melt(selectset,c("Subject","Activity"),variable.name="Signal")
longset <- group_by(longset,Subject,Activity,Signal)
averageset <- ungroup(summarise(longset,average=mean(value)))
separateset <- separate(averageset,Signal, into = c("Domain","Component","Signal","Statistic","Direction"))

#Task 5 - Froms the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

TidyDataSet <- spread(separateset,Statistic,average)
View(TidyDataSet)
names(TidyDataSet)[7] <- "average Mean"
names(TidyDataSet)[8] <- "average Std"
write.table(TidyDataSet,file="Tidy_Data_Set.txt",row.names = FALSE)

