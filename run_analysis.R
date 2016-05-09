# Ian 
### Download & Unzip data set
If (!file.exists("dataset.zip")) {
        xfileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(xfileURL,"dataset.zip", method="curl") 
}
unzip ("dataset.zip")
#Read descriptive files in
aLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
Features <- read.table("UCI HAR Dataset/features.txt")

# Convert Fields 
aLabels$V2 <-as.character(aLabels$V2)
Features$V2 <- as.character(Features$V2)
sFeatures <- grep(".*mean.|*std.*",Features$V2)

#Read the data files in
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")[sFeatures]
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")[sFeatures]
rbindx <- rbind (xTrain,xTest)
yTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
rbindy <- rbind (yTrain,yTest)

subjTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
rBindTT <- rbind(subjTrain, subjTest)

allData <- cbind(rBindTT,rbindy,rbindx)
nFeatures <- Features[sFeatures,2]
colnames(allData) <- c("subject", "activity" , nFeatures)

#output the tidy data file

write.table(allData,"tidy.txt", row.names = FALSE , quote = FALSE)



