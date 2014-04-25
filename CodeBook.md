# Code Book for run_Analysis.R script

This markdown file describes the pre-process that sets the context (or pre-condition) for the actual script, the actual script operations (i.e. data acquisition, cleansing, and transformation processes), and finally describes the variables of *tidy* data sets that script outputs. 

## Acquiring and storing Raw data (outside the script)
The raw data for this script has been acquired from the Getting & Cleaning data [Coursera assignment page][1]. As a side note, this raw data has been originally sourced from following [study][2].

This zip file was downloaded from the [Coursera link][1], and saved on to local repository named "gettingandcleaningdata"  which , in turn, is linked to a github remote of same name where this markdown file can be found.

The contents of the zipfile were extracted to directory called "data". The components of the zip file  extracted as sub-directories and files under "UCI HAR Dataset" directory (which itself was under "data"). The contents of "UCI HAR Dataset" directory were pulled up one level and this directory was deleted. The raw data now exists under directory "data" in the repo.

## Understanding the data (outside the script)
Based on the review of the "README.md" file located under the data directory, it is clear that the training and test data sets came from the same source. Please refer to [this file][3] for a more detailed overview. The summary is that the observation data is stored in "data/Test/X_test" and "data/Train/X_train.txt" with each record in each file constituting an observation. The associated activity (1-6) for each of these observations can be found in "data/Test/y_test.txt" and "data/Train/y_train.txt" files respectively. The subject (1-30) associated with these observations can be found in "data/test/subject_test.txt" and "data/train/subject_train.txt"

## Merging training and test sets (inside the script)
The script loads the test data from X_test.txt, adds activity index from y_test.txt as well as subject index from subect_test.txt into a working dataframe object. It similarly loads the training set (from analogous files) into another dataframe object. The final working data set is obtained by combining the test and train dataframes.

## Creating the Tidy Data set #1 (inside the script)
The working data set loaded in the previous step contains all available features, a listing of which is available [here][4]. The methodology used to capture these features and additional relevant information can be found [here][5]. The scope of the first tidy data set is limited to the mean and standard deviation(SD) of each base measure from above universe. The  said features were extracted into a seperate dataframe object tidydf1, which also had activity descriptions referenced in . The complete list of fields in this tidy dataset tidydf1 is as follows:

	==================

	"actIndex" : This variable denotes the index of the activity and ranges from 1-6 with meaning as denoted in [this][6] file.

	The next 33 fields reference the mean values of their respective metric as is evident from their name
	"tBodyAcc-mean()-X"
	"tBodyAcc-mean()-Y"
	"tBodyAcc-mean()-Z"
	"tGravityAcc-mean()-X"
	"tGravityAcc-mean()-Y"
	"tGravityAcc-mean()-Z"
	"tBodyAccJerk-mean()-X"
	"tBodyAccJerk-mean()-Y"
	"tBodyAccJerk-mean()-Z"
	"tBodyGyro-mean()-X"
	"tBodyGyro-mean()-Y"
	"tBodyGyro-mean()-Z"
	"tBodyGyroJerk-mean()-X"
	"tBodyGyroJerk-mean()-Y"
	"tBodyGyroJerk-mean()-Z"
	"tBodyAccMag-mean()"
	"tGravityAccMag-mean()"
	"tBodyAccJerkMag-mean()"
	"tBodyGyroMag-mean()"
	"tBodyGyroJerkMag-mean()"
	"fBodyAcc-mean()-X"
	"fBodyAcc-mean()-Y"
	"fBodyAcc-mean()-Z"
	"fBodyAccJerk-mean()-X"
	"fBodyAccJerk-mean()-Y"
	"fBodyAccJerk-mean()-Z"
	"fBodyGyro-mean()-X"
	"fBodyGyro-mean()-Y"
	"fBodyGyro-mean()-Z"
	"fBodyAccMag-mean()"
	"fBodyBodyAccJerkMag-mean()"
	"fBodyBodyGyroMag-mean()"
	"fBodyBodyGyroJerkMag-mean()"

	The next 33 fields reference the standard deviation values of their respective metric as is evident from their name
	"tBodyAcc-std()-X"
	"tBodyAcc-std()-Y"
	"tBodyAcc-std()-Z"
	"tGravityAcc-std()-X"
	"tGravityAcc-std()-Y"
	"tGravityAcc-std()-Z"
	"tBodyAccJerk-std()-X"
	"tBodyAccJerk-std()-Y"
	"tBodyAccJerk-std()-Z"
	"tBodyGyro-std()-X"
	"tBodyGyro-std()-Y"
	"tBodyGyro-std()-Z"
	"tBodyGyroJerk-std()-X"
	"tBodyGyroJerk-std()-Y"
	"tBodyGyroJerk-std()-Z"
	"tBodyAccMag-std()"
	"tGravityAccMag-std()"
	"tBodyAccJerkMag-std()"
	"tBodyGyroMag-std()"
	"tBodyGyroJerkMag-std()"
	"fBodyAcc-std()-X"
	"fBodyAcc-std()-Y"
	"fBodyAcc-std()-Z"
	"fBodyAccJerk-std()-X"
	"fBodyAccJerk-std()-Y"
	"fBodyAccJerk-std()-Z"
	"fBodyGyro-std()-X"
	"fBodyGyro-std()-Y"
	"fBodyGyro-std()-Z"
	"fBodyAccMag-std()"
	"fBodyBodyAccJerkMag-std()"
	"fBodyBodyGyroMag-std()"
	"fBodyBodyGyroJerkMag-std()"

	"subjectIndex": number from 1 to 30 that refers to the ID of the subject who provided this observation
	"actDesc": description of the activity performed by the subject. This field is abbreviated into a number in the actIndex field.

	==================


## Creating the Tidy Data set #2 (inside the script)
The script computes the average of each of the 33 mean and 33 SD features (66 total) by subject and by activity and provides a summary dataframe object called tidydf2. This object contins same fields as the previous tidydf1.



  [1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  [2]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  [3]: https://github.com/nandatascientist/gettingandcleaningdata/blob/master/data/README1.txt
  [4]: https://github.com/nandatascientist/gettingandcleaningdata/blob/master/data/features.txt
  [5]: https://github.com/nandatascientist/gettingandcleaningdata/blob/master/data/features_info.txt
  [6]: https://github.com/nandatascientist/gettingandcleaningdata/blob/master/data/activity_labels.txt