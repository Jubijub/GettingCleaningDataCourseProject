# GettingCleaningDataCourseProject by Jubijub

## Prerequisites
1. The script will require the dplyr package
2. You can install those by doing `install.packages("dyplr")

## Step by step

1. Clone this repository somewhere on your computer
2. Open an R session, and set the working directory to be the same as the `run_analysis.R` script, which should be the root of the clone project
3. Type `source("run_analysis.R")` : the script will carry out the work, and produce a result file in the same folder, called `averaged_data.txt` according to the process described below in **Data transformation**.
4. Be sure to check the [Code book](https://github.com/Jubijub/GettingCleaningDataCourseProject/blob/master/Codebook.md)

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
9. **This results in a clean, "wide" summary dataset** : 
  * one variable per column (subject, activity, and all features measured, with one column per feature)
  * and each row is a different observation for each variable.
  * the table contains only one kind of data (accelerometer data from one specific experience)
  * there is a top row with the variable names in a readable way
  * there is a code book explaining how the data has been produced
  
10. the resulting table is exported in a an `averaged_data.txt` file, in the working directory.

##Troubleshooting
### The download doesn't take place automatically
Being a Windows user, call to `download.file` doesn't specify any `method="curl"` as it fails download on our machines. Should download fail under Mac/Linux, you can manually supply the UCI dataset by placing the zip provided for the project, renamed "UCIDataset.zip" in the same directory as the run_analysis.R script, so that the scripts can access it via `UCIDataset.zip`
You can simply source again the script after providing the zip : `source("run_analysis.R")`


