#imports
library(dplyr)

# read in files
subject_train <- read.table('./train/subject_train.txt')
X_train <- read.table('./train/X_train.txt')
y_train <- read.table('./train/y_train.txt')
subject_test <- read.table('./test/subject_test.txt')
X_test <- read.table('./test/X_test.txt')
y_test <- read.table('./test/y_test.txt')
featureNames <- read.table('features.txt')

#merge X training, test, and subject data
featureData <- rbind(X_train, X_test)
subjectNo <- rbind(subject_train, subject_test)

#set meaningful column name
subjectNo <- rename(subjectNo, 'subjectNo' = V1)

#extract feature names
featureNames <- featureNames[2] #because the first column is indices

#subset training data by selecting columns of mean and std measurements
features <-
  featureData[, which(grepl(('.mean\\(\\)(.)?|.std.)'), featureNames[, 1]))]

#select relevant variable names from featureNames
featureVec <-
  featureNames[which(grepl(('.mean\\(\\)(.)?|.std.'), featureNames[, 1])),]

#clean up variable names
featureVec <- gsub('BodyBody', 'Body', featureVec) #get rid of typos
featureVec <- gsub('\\(\\)', '', featureVec) #get rid of punctuation
featureVec <- gsub('-', '', featureVec) # more punctuation

#set descriptive variable names
features <- setNames(features, featureVec)

#merge y training and test data
labels <- rbind(y_train, y_test)

#make activity names descriptive 
labels <- labels %>% mutate(V1 = factor(
  V1,
  levels = 1:6,
  labels =
    c(
      'WALKING',
      'WALKING_UPSTAIRS',
      'WALKING DOWNSTAIRS',
      'SITTING',
      'STANDING',
      'LAYING'
    )
)) %>% rename('activity' = V1) #rename column

#finish
tidyData <- cbind(subjectNo, labels, features)
tidyData <- tidyData %>% group_by(subjectNo, activity) %>%
  summarise_all(mean)

write.table(tidyData, file='tidyData.txt')