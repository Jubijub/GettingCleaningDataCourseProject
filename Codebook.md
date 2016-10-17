#Codebook for Getting and Cleaning data - Peer graded project

## Table of content
1. Study design
2. Data acquisition
3. Data transformation
4. Code book (variable description)

## Study design
The data manipulation performed as described below leverages the data from the [UCI Human activity Recogtnition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).The previous link explains the experimental setup, which can also be found in the README.txt in the `./rawdata/UCI HAR Dataset` folder.

##Data acquisition
### General treatment of source files
No original files is modified by the scripts. All the processing is done in memory using R.
### User expected steps
1. clone the repository from GitHub
2. The user is expected to set the R session working directory to same directory as the run_analysis.R script was cloned

### Steps carried out automatically
1. Data is downloaded automatically from the supplied online archive. The zip is stored in the working directory.If the zip has been previously downloaded it will not be downloaded again.
2. The UCI archive will be unzipped automatically in a `rawdata`subfolder (unless this already happened before)

##Data transformation
> All those steps will be taken care of automatically by the script

1. Original data has been split into a training set and a test set : the first goal is to merge them.
2. All 3 tables are merged using row binding, to form 3 sets
  * Measurements : accelerometers measurements (features)
  * MeasurementsLabel : the activities undertaken during the measurements (activities)
  * MeasurementSubjects : the subject undertaking the activities (subjects)
  * all temporary data is cleanup, for memory preservation
3. Features are filtered to keep only the ones describing mean or standard deviation values
4. The measurements table is updated with the proper feature names
  * Feature names have been cleaned to remove useless parenthesis, as well as turned to lower case.Dash and underscores have been kept for readability, as the variable names are very long.
  * Measurement table receives the proper feature names
5. The measurementsLabel table is updated with the proper activity name
  * Activity names have been cleaned (lowercase). Underscores have been kept for readability (as the values are lowercase).
  * MeasurementLabel receives the proper activity names
6. Proper column names are given where missing, to describe "activity" and "subject"
7. all 3 tables are merged together and rearranged
  * column bind, with subject and activity first
  * all data is arranged in ascending order or subject, then activity
  * **At this point this is a clean "wide" dataset** : one variable per column, each row is a different observation
8. A summary dataset is produced, showing only the average for each feature per subject per activity
  * Dplyr package is used to produce the summary, after grouping the data by subject by activity
  * At this point the dataset is clean, but very wide, so Reshape2 package is used to melt the dataframe into a long dataframe
  * A long format has been chosen as it's the recommended format for a lot of analysis.
  * header names are updated for clarify (feature and average replaced reshape2 default variable and value)
9. **This results in a clean, "long" summary dataset** : 
  * one variable per column (subject, activity, variable, value)
  * and each row is a different observation for each variable.
  * the table contains only one kind of data (accelerometer data from one specific experience)
  * there is a top row with the variable names in a readable way
  * there is a code book explaining how the data has been produced
  
10. the resulting table is exported in a an `averaged_data.txt` file, in the working directory.


##Code book
1. Subject
  * Integer Factor variable with 30 levels
  * using the same subject encoding as the original study (from 1 to 30)
2. activity
  * Character Factor variable with 6 levels
  * litteral text description of the activity, which can take one of this 6 values :laying, sitting, standing, walking, walking\_downstairs, walking\_upstairs
3. feature
  * Character Factor with 79 levels
  * Each variable name describes the type of accelerometer movement, the axis, etc... It is fully described in the `features_info.txt` located in `./rawdata/UCI HAR Dataset` folder.
4. average
  * the average for the matching variable, summurized out of all the observations for a given subject, for a given activity.
  



