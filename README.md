# GettingCleaningDataCourseProject by Jubijub

## Getting source data
The script will automatically download the UCI dataset from the Cloudfront url provided in the assignment inside of R working directory.

Note : being a Windows user, call to `download.file` doesn't specify any `method="curl"` as it fails download on our machines. Should download be broken, you can manually supply the UCI dataset by placing the zip provided for the project, renamed "UCIDataset.zip" in the same directory as the run_analysis.R script, so that the scripts can access it via `UCIDataset.zip`

## Extracting source data
The script will automatically extract the zip into `./rawdata/UCI HAR Dataset/` . This original raw data will not be modified. All modifications on the raw data will take place in memory, using R.

