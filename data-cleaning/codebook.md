---
Title: "Getting and Cleaning Data Course Project"
author: "Jostein Barry-Straume"
date: "April 18, 2017"
output: html_document
---

**Instructions**
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.

**Review criteria**

1. The submitted data set is tidy.
2. The Github repo contains the required scripts.
3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4. The README that explains the analysis files is clear and understandable.
5. The work submitted for this project is the work of the student who submitted it.

**Getting and Cleaning Data Course Project**
>The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1. A tidy data set as described below
2. A link to a Github repository with your script for performing the analysis
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

>One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

>Here is the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

*Good luck!*

# Dataset Creation
>Please refer to run_analysis.md for detailed explanations as to how the data was downloaded, gathered, narrowed, and cleaned.

# Variables

```r
variableNamesCodebook <- read.csv("variable_names_codebook.csv", header = FALSE)
names <- variableNamesCodebook[,2]
```

```
## Error in `[.data.frame`(variableNamesCodebook, , 2): undefined columns selected
```

```r
names
```

```
##  [1] x                        subject_id              
##  [3] activity_labels          tBodyAccMeanX           
##  [5] tBodyAccMeanY            tBodyAccMeanZ           
##  [7] tGravityAccMeanX         tGravityAccMeanY        
##  [9] tGravityAccMeanZ         tBodyAccJerkMeanX       
## [11] tBodyAccJerkMeanY        tBodyAccJerkMeanZ       
## [13] tBodyGyroMeanX           tBodyGyroMeanY          
## [15] tBodyGyroMeanZ           tBodyGyroJerkMeanX      
## [17] tBodyGyroJerkMeanY       tBodyGyroJerkMeanZ      
## [19] tBodyAccMagMean          tGravityAccMagMean      
## [21] tBodyAccJerkMagMean      tBodyGyroMagMean        
## [23] tBodyGyroJerkMagMean     fBodyAccMeanX           
## [25] fBodyAccMeanY            fBodyAccMeanZ           
## [27] fBodyAccJerkMeanX        fBodyAccJerkMeanY       
## [29] fBodyAccJerkMeanZ        fBodyGyroMeanX          
## [31] fBodyGyroMeanY           fBodyGyroMeanZ          
## [33] fBodyAccMagMean          fBodyBodyAccJerkMagMean 
## [35] fBodyBodyGyroMagMean     fBodyBodyGyroJerkMagMean
## [37] tBodyAccStdX             tBodyAccStdY            
## [39] tBodyAccStdZ             tGravityAccStdX         
## [41] tGravityAccStdY          tGravityAccStdZ         
## [43] tBodyAccJerkStdX         tBodyAccJerkStdY        
## [45] tBodyAccJerkStdZ         tBodyGyroStdX           
## [47] tBodyGyroStdY            tBodyGyroStdZ           
## [49] tBodyGyroJerkStdX        tBodyGyroJerkStdY       
## [51] tBodyGyroJerkStdZ        tBodyAccMagStd          
## [53] tGravityAccMagStd        tBodyAccJerkMagStd      
## [55] tBodyGyroMagStd          tBodyGyroJerkMagStd     
## [57] fBodyAccStdX             fBodyAccStdY            
## [59] fBodyAccStdZ             fBodyAccJerkStdX        
## [61] fBodyAccJerkStdY         fBodyAccJerkStdZ        
## [63] fBodyGyroStdX            fBodyGyroStdY           
## [65] fBodyGyroStdZ            fBodyAccMagStd          
## [67] fBodyBodyAccJerkMagStd   fBodyBodyGyroMagStd     
## [69] fBodyBodyGyroJerkMagStd 
## 69 Levels: activity_labels fBodyAccJerkMeanX ... x
```

# Snapshot of data

```r
summary <- read.table("summary_run_data.txt")
head(summary)
```

```
##           V1              V2            V3            V4            V5
## 1 subject_id activity_labels tBodyAccMeanX tBodyAccMeanY tBodyAccMeanZ
## 2          1        STANDING    0.28858451  -0.020294171   -0.13290514
## 3          1        STANDING    0.27841883  -0.016410568   -0.12352019
## 4          1        STANDING    0.27965306  -0.019467156   -0.11346169
## 5          1        STANDING    0.27917394  -0.026200646   -0.12328257
## 6          1        STANDING    0.27662877  -0.016569655   -0.11536185
##                 V6               V7               V8                V9
## 1 tGravityAccMeanX tGravityAccMeanY tGravityAccMeanZ tBodyAccJerkMeanX
## 2       0.96339614      -0.14083968       0.11537494       0.077996345
## 3       0.96656113      -0.14155127       0.10937881       0.074006709
## 4        0.9668781      -0.14200984       0.10188392       0.073635962
## 5       0.96761519      -0.14397645      0.099850143       0.077320614
## 6        0.9682244      -0.14875022      0.094485896       0.073444363
##                 V10               V11            V12            V13
## 1 tBodyAccJerkMeanY tBodyAccJerkMeanZ tBodyGyroMeanX tBodyGyroMeanY
## 2      0.0050008031      -0.067830808  -0.0061008489   -0.031364791
## 3      0.0057711041       0.029376633    -0.01611162   -0.083893777
## 4      0.0031040366     -0.0090456308   -0.031698294    -0.10233542
## 5       0.020057642     -0.0098647722   -0.043409983   -0.091386182
## 6       0.019121574       0.016779979   -0.033960416   -0.074708034
##              V14                V15                V16                V17
## 1 tBodyGyroMeanZ tBodyGyroJerkMeanX tBodyGyroJerkMeanY tBodyGyroJerkMeanZ
## 2      0.1077254         -0.0991674       -0.055517369       -0.061985797
## 3     0.10058429        -0.11050283       -0.044818731       -0.059242822
## 4    0.096126876        -0.10848567       -0.042410306       -0.055828829
## 5    0.085537699       -0.091169889        -0.03633262        -0.06046466
## 6    0.077392035       -0.090770099       -0.037632533       -0.058289319
##               V18                V19                 V20              V21
## 1 tBodyAccMagMean tGravityAccMagMean tBodyAccJerkMagMean tBodyGyroMagMean
## 2     -0.95943388        -0.95943388         -0.99330586      -0.96895908
## 3     -0.97928915        -0.97928915         -0.99125349      -0.98068314
## 4     -0.98370313        -0.98370313         -0.98853127      -0.97631707
## 5     -0.98654176        -0.98654176         -0.99307804      -0.98205988
## 6     -0.99282715        -0.99282715            -0.99348      -0.98520373
##                    V22           V23           V24           V25
## 1 tBodyGyroJerkMagMean fBodyAccMeanX fBodyAccMeanY fBodyAccMeanZ
## 2          -0.99424782   -0.99478319    -0.9829841   -0.93926865
## 3           -0.9951232   -0.99745072   -0.97685173   -0.97352267
## 4          -0.99340322   -0.99359409   -0.97251146   -0.98330396
## 5          -0.99550216   -0.99549062   -0.98356972   -0.99107978
## 6          -0.99580756   -0.99728592   -0.98230099   -0.98836944
##                 V26               V27               V28            V29
## 1 fBodyAccJerkMeanX fBodyAccJerkMeanY fBodyAccJerkMeanZ fBodyGyroMeanX
## 2       -0.99233245       -0.98716991       -0.98969609    -0.98657442
## 3       -0.99503222       -0.98131147       -0.98973975    -0.97738671
## 4        -0.9909937       -0.98164225       -0.98756628    -0.97543322
## 5       -0.99444663       -0.98872722       -0.99135422    -0.98710958
## 6       -0.99629204       -0.98879002       -0.99062442    -0.98244648
##              V30            V31             V32                     V33
## 1 fBodyGyroMeanY fBodyGyroMeanZ fBodyAccMagMean fBodyBodyAccJerkMagMean
## 2    -0.98176153    -0.98951478     -0.95215466             -0.99372565
## 3    -0.99253003    -0.98960578     -0.98085662             -0.99033549
## 4    -0.99371467     -0.9867557     -0.98779477             -0.98928007
## 5    -0.99360151    -0.98719126     -0.98751866             -0.99276892
## 6     -0.9929838    -0.98866644     -0.99359085             -0.99552281
##                    V34                      V35          V36          V37
## 1 fBodyBodyGyroMagMean fBodyBodyGyroJerkMagMean tBodyAccStdX tBodyAccStdY
## 2          -0.98013485              -0.99199044   -0.9952786  -0.98311061
## 3          -0.98829555              -0.99585386  -0.99824528  -0.97530022
## 4          -0.98925477               -0.9950305  -0.99537956  -0.96718701
## 5           -0.9894128              -0.99522071  -0.99609149   -0.9834027
## 6          -0.99143303              -0.99509278  -0.99813862  -0.98081727
##            V38             V39             V40             V41
## 1 tBodyAccStdZ tGravityAccStdX tGravityAccStdY tGravityAccStdZ
## 2  -0.91352645     -0.98524969     -0.98170843     -0.87762497
## 3  -0.96032199     -0.99741134     -0.98944741     -0.93163868
## 4  -0.97894396     -0.99957395     -0.99286582     -0.99291723
## 5   -0.9906751     -0.99664558     -0.98139281     -0.97847643
## 6  -0.99048163     -0.99842928     -0.98809824     -0.97874493
##                V42              V43              V44           V45
## 1 tBodyAccJerkStdX tBodyAccJerkStdY tBodyAccJerkStdZ tBodyGyroStdX
## 2      -0.99351906      -0.98835999      -0.99357497   -0.98531027
## 3      -0.99554814      -0.98106363       -0.9918457   -0.98311996
## 4      -0.99074281      -0.98095561      -0.98968664   -0.97629211
## 5      -0.99269737      -0.98755275      -0.99349757    -0.9913848
## 6      -0.99642017      -0.98835871       -0.9924549   -0.98518357
##             V46           V47               V48               V49
## 1 tBodyGyroStdY tBodyGyroStdZ tBodyGyroJerkStdX tBodyGyroJerkStdY
## 2   -0.97662344   -0.99220528       -0.99211067       -0.99251927
## 3    -0.9890458   -0.98912123       -0.98987256        -0.9972926
## 4   -0.99355182   -0.98637871       -0.98846185       -0.99563214
## 5   -0.99240732   -0.98755418        -0.9911194       -0.99664096
## 6   -0.99237812   -0.98740185       -0.99135446       -0.99647298
##                 V50            V51               V52                V53
## 1 tBodyGyroJerkStdZ tBodyAccMagStd tGravityAccMagStd tBodyAccJerkMagStd
## 2       -0.99205528     -0.9505515        -0.9505515        -0.99433641
## 3         -0.993851    -0.97605707       -0.97605707        -0.99169441
## 4       -0.99153184    -0.98801962       -0.98801962         -0.9903969
## 5       -0.99332889    -0.98642135       -0.98642135         -0.9933808
## 6       -0.99451099    -0.99127536       -0.99127536        -0.99585371
##               V54                 V55          V56          V57
## 1 tBodyGyroMagStd tBodyGyroJerkMagStd fBodyAccStdX fBodyAccStdY
## 2     -0.96433518         -0.99136761  -0.99542175  -0.98313297
## 3     -0.98375419         -0.99610164  -0.99868026  -0.97492981
## 4     -0.98605146         -0.99509104  -0.99631281  -0.96550593
## 5     -0.98735112          -0.9952666  -0.99631211  -0.98324437
## 6     -0.98906257         -0.99525804  -0.99860647  -0.98012947
##            V58              V59              V60              V61
## 1 fBodyAccStdZ fBodyAccJerkStdX fBodyAccJerkStdY fBodyAccJerkStdZ
## 2  -0.90616498      -0.99582068      -0.99093631      -0.99705167
## 3  -0.95543811      -0.99665235      -0.98208394      -0.99262682
## 4  -0.97704932       -0.9912488      -0.98141476       -0.9904159
## 5  -0.99022911      -0.99137827      -0.98692685      -0.99439076
## 6  -0.99191496      -0.99690254      -0.98860666      -0.99290652
##             V62           V63           V64            V65
## 1 fBodyGyroStdX fBodyGyroStdY fBodyGyroStdZ fBodyAccMagStd
## 2   -0.98503264   -0.97388607   -0.99403493    -0.95613397
## 3   -0.98490434   -0.98716807   -0.98978468    -0.97586576
## 4   -0.97664224   -0.99339895   -0.98732821    -0.98901548
## 5   -0.99281036   -0.99164605   -0.98867764    -0.98674196
## 6   -0.98598182   -0.99195582   -0.98794433    -0.99006346
##                      V66                 V67                     V68
## 1 fBodyBodyAccJerkMagStd fBodyBodyGyroMagStd fBodyBodyGyroJerkMagStd
## 2            -0.99375495         -0.96130944             -0.99069746
## 3            -0.99196029         -0.98332192             -0.99639947
## 4            -0.99086668         -0.98602772             -0.99512739
## 5            -0.99169983         -0.98783575             -0.99523693
## 6            -0.99438901         -0.98905935             -0.99546483
```

