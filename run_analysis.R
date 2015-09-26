# The column names are in 'features.txt'.
col_names <- read.table("UCI HAR Dataset/features.txt")[,2]
# Column names we want to keep at the end: means or standard deviations.
# The only one's we're interested in are ones that end with either
# - mean(); or
# - std().
keep_cols <- grepl("-mean\\(\\)", col_names) | grepl("-std\\(\\)", col_names)
# Modify col_names to be a bit nicer (get rid of , () and -).
col_names <- gsub('\\(', '_', gsub('\\)', '', gsub(',', '.', gsub('\\(\\)', '', gsub('-', '_', col_names)))))

# Read in the training and test data.
data <- read.table("UCI HAR Dataset/train/X_train.txt", col.names=col_names)
# Append the test data to the train data.
data <- rbind(data, read.table("UCI HAR Dataset/test/X_test.txt", col.names=col_names))

# Filter out the columns we don't want.
data <- data[keep_cols]

# Also read in the activity data.
activity_data <- rbind(read.table("UCI HAR Dataset/train/y_train.txt"),
                       read.table("UCI HAR Dataset/test/y_test.txt"))
# Modify the 'Activities' list.
# Start with a vector of activities corresponding to each number.
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")[,2]
activity <- apply(activity_data, 1, function(n) activity_names[n])

# Finally, the subject data.
subject <- rbind(read.table("UCI HAR Dataset/train/subject_train.txt"),
                 read.table("UCI HAR Dataset/test/subject_test.txt"))

data <- cbind(subject, activity, data)
names(data)[1:2] <- c("Subject", "Activity")

# Use dplyr to summarise each variable, grouped by subject and activity
# by taking it's mean.
library(dplyr)
averages <- (data
             %>% group_by(Subject, Activity)
             %>% summarise_each(funs(mean))
             )

# Write the output to a file.
write.table(averages, file="averages.txt", row.name=FALSE)
