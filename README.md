##Getting and Cleaning Data Peer Assessment Project.

This code in this repository can be used to clean the data on [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) which can be downloaded [here](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).

The output of this process is a summary of the original data.
There are 30 test subjects with 6 physical activities each.
The data presented is the mean of all `mean` and `std` observations for each subject participating in each activity.

The data is created from the original data by the following process.

* Start with the data available [here](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip).
* Read in the column names from the `features.txt` file.
* Modify the column names by making the following replacements, this gives nicer names which will be easier to use with `R`:
    1. Replace a hyphen with an underscore: `- -> _`;
    2. Replace an open-close bracket with nothing: `() -> `;
    3. Replace a comma with a full-stop: `, -> .`;
    4. Replace a single close bracket with nothing: `) -> `; and
    5. Replace a single open bracket with an underscore: `( -> _`.
* After renaming the columns, we read in the data and set the column names.  The data is read in with `train/X_train.txt` stacked on top of `test/X_test.txt`.
* We then subset this data by removing the columns we're not interested in.  The only columns we want to keep here are the ones that end in `-mean()` or `-std()` which correspond to the mean and standard deviation of each variable.  NOTE: This corresponds to the **original** names before the replacements were made above.
* The activity and subject data is then read in, these are found in the `y_*.txt` and `subject_*.txt` files respectively.  These are read in in the same `train` stacked on top of `test` order as before.
* We re-name the `activity` data, which is just numbers, using the names found in `activity_labels.txt`.
* These are then added to the main data, by appending the columns on the left.  The column ordering is now `Subject`, `Activity`,...
* From here, we use the `dplyr` package to summarise the observations.  First we group each observation by subject and the activity the subject was partaking.  We then summarise every column by taking the mean for each group.
* This is the final data table which we end up with.

