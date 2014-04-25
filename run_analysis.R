# Refer to CodeBook.md for initial context
# assume that the working directory is the local repo "gettingandcleaningdata"


################### 1. LOADING & MERGING DATA FROM FILES ###################

# we will (A) load & prepare  test files, (B) load & prepare train files,
#   (C) merge the two into a common dataset, and (D) name feature columns

## Part A 

# load the testdata into a df and also layer in the subject and activity references

testdf<-read.table("./data/test/X_test.txt") #2947 rows and 561 cols
tstlbl<-read.table("./data/test/y_test.txt") #2947 rows and 1 col
# tstlbl has a number from [1-6] corresponding to each of the 2947 rows that denote 
# the activity associated with the observation

testdf$actIndex<-tstlbl[,1] # added activity index to testdf

tstsub<-read.table("./data/test/subject_test.txt") #2947 rows and 1 col
# tstsub has a number from [1-30] corresponding to each of the 2947 rows that denote 
# the subject (i.e. person) associated with the observation

testdf$subjectIndex<-tstsub[,1] # added subject index to testdf

# at this point testdf has 2947 observations on 561 features in the first 561 cols. 
# col 562 and Col 563 are the two indexes we added above.

## Part B 

# load the traindata into a df and also layer in the subject and activity references

traindf<-read.table("./data/train/X_train.txt") #7352 rows and 561 cols
trnlbl<-read.table("./data/train/y_train.txt") #7352 rows and 1 col
# trnlbl has a number from [1-6] corresponding to each of the 7352 rows that denote 
# the activity associated with the observation

traindf$actIndex<-trnlbl[,1] # added activity index to traindf

trnsub<-read.table("./data/train/subject_train.txt") #7352 rows and 1 col
# trnsub has a number from [1-30] corresponding to each of the 7352 rows that denote 
# the subject (i.e. person) associated with the observation
        
traindf$subjectIndex<-trnsub[,1] # added subject index to testdf

# at this point traindf has 7352 observations on 561 features in the first 561 cols. 
# col 562 and Col 563 are the two indexes we added above.


## Part C 

# merge testdf and traindf into one large datadf.
datadf<-rbind(traindf,testdf) # 10299 (7352+2947) rows and 563 cols


## Part D

#load feature names from the features.txt file into a dataframe 
# called features. It will have feature # and col name i.e. feature name
features<-read.table("./data/features.txt") 


# set  all  colnames into a character vector called dfnames
dfnames<-c(as.character(features[,2]),"actIndex","subjectIndex")
# since features[,2] is a factor, coercing to character 
# to reference the value instead of its level. this will give us the 
# first 561 feature names and the other two col names are added explicitly

names(datadf)<-dfnames # rename operation complete!!!!

# datadf is the working dataframe that we will use for creating 
# required tidy data sets

rm(traindf)
rm(testdf)
# removing these heavy objects from R memmory since we wont need them further

################### 2. CREATING FIRST TIDY DATA SET ###################

# in this section we will create a tidy data set by (A) extracting 
# mean & SD of base features and (B) adding descriprive names for activities

## Part A

# the goal here is to extract all features that represent a mean or 
# standard devision of a base measure. we will do this by looking for 
# "-mean()" or "-std()" in the feature names. 
# Note:  measures like *-meanfreq() or angle(..,gravityMean) 
# dont qualify per  our criteria  since they are base measures themselves

featureNames<-as.character(features[,2])

meanIndex<-grep("-mean()",featureNames, fixed=TRUE) 
stdIndex<-grep("-std()",featureNames, fixed=TRUE)
# grep does pattern matching. fixed=TRUE looks for an exact match.

tidyFeatureIndex<-c(meanIndex,stdIndex,562:563)
# the integer vector above corresponds to all the cols in datadf that we want to 
# extract into our tidy dataset since the features in datadf have been stored in 
# same order in which they have been stored in features.txt (& features dataframe)

# note that tidyFeatureIndex will reference 66 features + 2 index cols

## Part B
#load activity descriptions from the activity_labels.txt file into a dataframe 
# called activities. It will have activity  # and activity  name
activities<-read.table("./data/activity_labels.txt") 
names(activities)<-c("actIndex","actDesc") # rename cols to enable merging.

tidydf1<-merge(datadf[,tidyFeatureIndex],activities,by.x="actIndex",by.y="actIndex") 
# merged activities & datadf to get tidydf1 which now meets the following requirements:
# (a) combines test + train data (b) contains only the mean and SD measures [66 features]
# + 3 additional cols for actIndex, actDesc and subjectIndex and (c) contains 
# descriptive activity labels (actDesc)

rm(datadf)
# removing this  heavy object from R memory since we wont this  further

################### 3. CREATING SECOND TIDY DATA SET ###################

# Objective is get the average values of all the features in tidydf1 by
# subject and by activity

tmpList<-split(tidydf1[,1:68],list(tidydf1$subjectIndex,tidydf1$actIndex))
# split the tidy data set (less the last description col) by both subject and activity

tmpdf<-sapply(tmpList,colMeans)
# tmpdf is a matrix with the actual variables in the rows and the combination of 
# subject, activity as the columns. We need to transpose this to get the summary 
# we need

tidydf2<-merge(t(tmpdf),activities)
# here we transposed the matrix from previous step and added back the description
# from the activities df. The implied key here is actIndex

#tidydf2 therefore represents the mean of all the features by subject and by activity

rm(tmpList)
rm(tmpdf)
# removing all intermediate objects from session

################### 4. CREATE OUTPUT FILES ###################
write.table(tidydf1,file="meansddata.txt",sep=" ",row.names=FALSE)
write.table(tidydf2,file="avgmeansddata_bysub_byact.txt",sep=" ",row.names=FALSE)
