# Getting and Cleaning Data Course Project

This project involved preparing a tidy dataset from the *Human Activity Recognition Using Smartphones Data Set*, [available](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones) on the UCI Machine Learning Repository. More information about tidy data can be found in Hadley Wickham's [paper](https://vita.had.co.nz/papers/tidy-data.pdf) on the subject.

## About the data <sup>1</sup>
> The data were collected from experiments carried out with 30 volunteers aged between 19 and 48 years. Each volunteer was asked to perform 6 different activities: walking, sitting, laying, standing, walking upstairs and walking downstairs, wearing a smartphone (the Samsung Galaxy S II) on their waists. 3-axial linear acceleration and 3-axial angular velocity were captured using the smartphone's embedded accelerometer and gyroscope at a constant rate of 50 Hz, and the data were partitioned randomly in a 7:3 ratio for training and testing respectively.
>
>These raw data (sensor signals) were then preprocessed by applying noise filters and sampled in fixed-width sliding windows of 2.56 seconds and 50% overlap. The accelerometer signal, which had both body and gravitational motion components, was filtered into its two components using a low-pass Butterworth filter with a 0.3 Hz cutoff frequency.

<sup>1</sup> Reference: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.

## Files in the dataset
The data were downloaded into a folder named ``UCI HAR Dataset`` that included the following files, as described in the ``README.txt``: 
* ``README.txt``
* ``features_info.txt``: Shows information about the variables used on the feature vector.
* ``features.txt``: List of all features. 1 column and 561 rows.
* ``activity_labels.txt``: Links the class labels with their activity name. 2 columns and 6 rows.
* ``train/X_train.txt``: Training set. 561 columns and 7352 rows.
* ``train/y_train.txt``: Training labels. 1 column and 7352 rows.
* ``test/X_test.txt``: Test set. 561 columns and 2947 rows.
* ``test/y_test.txt``: Test labels. 1 column and 2947 rows.
* ``train/subject_train.txt`` and ``test/subject_test.txt``: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Two other folders, ``train/Inertial Signals`` and ``test/Inertial Signals`` were also downloaded, but were not used in this project.

## Files on this repo
* ``README.md`` is what you're reading now.
* ``run_analysis.r`` is an R script that performs the following tasks, as outlined in the instructions for the Coursera assignment: 
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* ``tidyData.txt`` is the tidy dataset which is obtained from running ``run_analysis.r``.
* ``CodeBook.md`` contains details about the variables in ``tidyData.txt`` and more info about the raw data.

## From Messy to Tidy Data
The following are more detailed steps about what ``run_analysis.r`` acccomplishes. Note that the working directory is set to ``./UCI HAR Dataset``.
  1. Read in all the files in the dataset, with the exception of ``README.txt`` and ``features_info.txt``, into R. The dataframes read in were assigned to variables that had the same name as the files being read from, with the exception of ``features.txt``, which was read into a variable called ``featureNames``.
  2. Merge ``subject_train`` and ``subject_test`` into dataframe ``subjectNo``, and ``X_train`` and ``X_test`` into dataframe ``featureData`` using the function ``rbind``.
  3. Select only mean and standard deviation measurement variables from ``featureNames`` and subset ``featureData`` according to these indices obtaining the dataframe ``features``. The indices were identified using ``grep`` and RegEx. 
  4. Clean up variable names and rename columns of ``features`` with meaningful names. Namely, a vector ``featureVec`` was created by subsetting ``featureNames`` using the relevant indices (mean and std measurements). Using the ``gsub`` function, the characters (, ), - were removed from variable names and typos (such as 'BodyBody') were corrected. Finally, column names in ``features`` were set to the values in ``featureVec`` using the ``setNames`` function.
  5. Merge ``y_train`` and ``y_test`` into dataframe ``labels`` using the function ``rbind``.
  6. Set descriptive activity names for the activity numbers in ``labels``. This involved mutating the column with default name ``V1`` in ``labels`` to a factor type with levels 1 to 6 and assigning the respective labels: WALKING, STANDING, etc.
  7. Merge ``subjectNo``, ``labels`` and ``features`` using the function ``cbind``.
  8. ``group_by`` subjectNo and activity, and calculate means for all remaining columns using ``summarise_all``. Store this dataframe in ``tidyData``.
  9. Write ``tidyData`` to a space-delimited .txt file using ``write.table``.
  
## How are the data tidy?
As outlined in Hadley Wickham's paper on tidy data, the criteria for data to be considered tidy are:
  1. *Each variable forms a column*: This is true because the 66 features in ``tidyData.txt`` that were selected from the original dataset of 561 features are each a variable and each form one separate column. The activity and subject number are also variables, and these are assigned their own columns as well.
  2. *Each observation forms a row*: This criterion is also satisfed since there is one separate row for each subject/activity pair, which is the 'observation' in this context.
  3. *Each type of observational unit forms a table*: This is true because the output file stores every subject/activity pair (all the observations) in one and only one table.

``tidyData.txt`` satisfies all these criteria.

## Reading ``tidyData.txt`` into R
  1. Download the Human Activity Recognition dataset from the UCI Machine Learning Repository.
  2. Set your R working directory to ``./UCI HAR Dataset``
  3. Download ``tidyData.txt``.
  4. Enter the following command into the console: 
  ``tidyData <- read.table(tidyData.txt, header=TRUE)``
