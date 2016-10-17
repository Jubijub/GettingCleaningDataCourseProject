# GettingCleaningDataCourseProject by Jubijub

## Step by step

1. Clone this repository somewhere on your computer
2. Open an R session, and set the working directory to be the same as the `run_analysis.R` script, which should be the root of the clone project
3. Type `source("run_analysis.R")` : the script will carry out the work, and produce a result file in the same folder, called `averaged_data.txt`
4. Be sure to check the [Code book](https://github.com/Jubijub/GettingCleaningDataCourseProject/blob/master/Codebook.md)

##Troubleshooting
### The download doesn't take place automatically
Being a Windows user, call to `download.file` doesn't specify any `method="curl"` as it fails download on our machines. Should download fail under Mac/Linux, you can manually supply the UCI dataset by placing the zip provided for the project, renamed "UCIDataset.zip" in the same directory as the run_analysis.R script, so that the scripts can access it via `UCIDataset.zip`
You can simply source again the script after providing the zip : `source("run_analysis.R")`

###I prefer wide datasets, and yours is long
You can simply comment line 71 and 73 of the script, and change the filename accordingly (make reference to independant instead of independantLong on the subsequent lines) to obtain a wide dataset :)

