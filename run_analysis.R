#Coursera homework "Getting and cleaning data week 4 project"
library(dplyr)
#1) Merge the training and the test sets to create one data set.
#creating dataframe X by merging read in X_test.txt and  X_train.txt
X <- rbind(read.table("train/X_train.txt"),read.table("test/X_test.txt"))
#creating dataframe y by merging read in y_test.txt and  y_train.txt
y <- rbind(read.table("train/y_train.txt"),read.table("test/y_test.txt"))
#creating dataframe subject by merging read in subject_test.txt and  subject_train.txt
subject<- rbind(read.table("train/subject_train.txt"),read.table("test/subject_test.txt"))
#adding a header
features <- read.table("features.txt")
colnames(X) <- features[,2] %>% trimws()
#2) Report mean and stdev columns
Extract_measurements <- X[,sort(c(grep('[Mm]ean',colnames(X)) , grep('std',colnames(X))))]
#3) Adding the activity descriptors
#reading the descriptors
activity <- read.table("activity_labels.txt")
colnames(activity) <-c("key","activity")
colnames(y) <- "key" 
colnames(subject) <- "subject"
#pasting the data
Extract_measurements<-cbind(merge(y,activity,by.x="key",by.y="key"),Extract_measurements)
Extract_measurements<-cbind(subject,Extract_measurements)
#4)labeling was done above
#5) calculate mean by subject and activity
#group
grouped_subject_activity <- Extract_measurements %>% group_by(subject,activity) %>% tally()
#calculate
summary_subject_activity <- Extract_measurements %>% group_by(subject,activity)
write.table(summary_subject_activity,"summary",row.name=FALSE) 


