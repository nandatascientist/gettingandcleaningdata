# Code Book for run_Analysis

This markdown file describes the data acquisition, cleansing, and transformation process carried out by the script "run_Analysis.R". 
It also describes the variables of *tidy* data sets that script outputs. 

## Acquiring and storing Raw data 
The raw data for this script has been acquired from the Getting & Cleaning data [Coursera assignment page][1]. As a side note, this raw data has been originally sourced from following [study][2].

This zip file was downloaded from the [Coursera link][1], and saved on to local repository named "gettingandcleaningdata"  which , in turn, is linked to a github remote of same name where this markdown file can be found.

The contents of the zipfile were extracted to directory called "data". The components of the zip file  extracted as sub-directories and files under "UCI HAR Dataset" directory (which itself was under "data"). The contents of "UCI HAR Dataset" directory were pulled up one level and this directory was deleted. The raw data exisits under directory "data" in the repo.

## Understanding the data
Based on the review of the "README.md" file located under the data directory, it is clear that the training and test data sets came from the same source. Please refer to [this file][3] for a more detailed overview. The summary is that the observation data is stored in "data/Test/X_test" and "data/Train/X_train.txt" with each record in each file constituting an observation. The associated activity (1-6) for each of these observations can be found in "data/Test/y_test.txt" and "data/Train/y_train.txt" files respectively. The subject (1-30) associated with these observations can be found in "data/test/subject_test.txt" and "data/train/subject_train.txt"




  [1]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  [2]: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
  [3]: <Link to original readme.md> file from repo