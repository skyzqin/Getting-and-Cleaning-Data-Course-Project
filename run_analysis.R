##1.read the data of xTest、yTest、subjectTest、xTrain、yTrain、subjectTrain、activityName、featureName��merge the data of test and train
xTest <- read.table("test\\X_test.txt")
yTest <- read.table("test\\y_test.txt")
subjectTest <- read.table("test\\subject_test.txt")
xTrain <- read.table("train\\X_train.txt")
yTrain <- read.table("train\\y_train.txt")
subjectTrain <- read.table("train\\subject_train.txt")
activityname <- read.table("activity_labels.txt")
featureLabel <- read.table("codebook.txt")
xTotal <- rbind(xTest,xTrain)
yTotal <- rbind(yTest, yTrain)
subjectTotal <- rbind(subjectTest,subjectTrain)
names(yTotal) <- c("activity")
names(subjectTotal) <- c("subject")
total <- cbind(xTotal, yTotal, subjectTotal)
##2.extracts the data of mean and std
columnnumbers <- c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543,562:563)
meanandstddata <- total[,columnnumbers]
##3.label the activity
for(i in 1:length(activityname$V1)){
  meanandstddata$activity <- gsub(activityname$V1[i],activityname$V2[i],meanandstddata$activity)
}
##4.Label the varaiarity
variabelnames <- c(as.character(featureLabel$V3), "activity", "subject")
names(meanandstddata) <- variabelnames
##5.create a tidy table and output the data
groups <- group_by(meanandstddata, activity,subject)
meandata <- summarise_each(groups, funs(mean), TBAMX:FBBGJMS)
write.table(meandata,"result.txt",row.names = FALSE)
