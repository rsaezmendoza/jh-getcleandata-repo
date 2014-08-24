#General requirements
The following is a list of notes regarding the files in the repo directory and the instructions followed within the script to create the output data set.

#File summary
* README.md : This file.
* run_analysis.R : R script with the instructions to perform the project requirements.
* CodeBook.txt : code book with the data dictionary.
* tidyDataset.txt : output data set example for an execution of the program.

#Instructions list/script 
Below are the summarization/data analysis steps performed to produce the output tidy data set.
1. Download the zip file with the source data required for the analysis.
2. Unzip the source data in the data directory ready to start working on it.
3. Load the dataset: master data, train and test data sets; setting the column names as readable descriptions
4. Combine test and train data sets to create a unique data set for the analysis
5. Filter the column names to show only the vars related with mean and std data
6. Add a column with the activity names to the data set
7. Create an independent tidy dataset with the average values of the vars., grouped by subject and activity
8. Write the output to a txt file

##Operationg system
OS used: Windows 7

##Test executed
Script run several times with successful results.

An example of a script execution run locally is included in the repository (tidyDataset.txt).
