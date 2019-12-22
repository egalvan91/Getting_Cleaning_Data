run_analysis <- function(){

    # Import Library dplyr
    library(dplyr)

    # Reading files activity_labels and features

    activity_labels <- read.table(file.path(getwd(), "UCI HAR Dataset/activity_labels.txt"), header = FALSE)
    features <- read.table(file.path(getwd(), "UCI HAR Dataset/features.txt"), header = FALSE)

    # Reading files x_test, y_test and subject_test

    x_test <- read.table(file.path(getwd(), "UCI HAR Dataset/test/X_test.txt"), header = FALSE)
    y_test <- read.table(file.path(getwd(), "UCI HAR Dataset/test/y_test.txt"), header = FALSE)
    subject_test <- read.table(file.path(getwd(), "UCI HAR Dataset/test/subject_test.txt"), header = FALSE)

    # Joining information with activity
    y_test$V1 <- activity_labels[y_test$V1, 2]

    # Rename columns
    names(x_test) <- features$V2
    names(y_test) <- "activity"
    names(subject_test) <- "idsubject"

    # Joining all the test information
    test <- cbind(subject_test, y_test, x_test)

    # Reading files x_train, y_train and subject_train
    x_train <- read.table(file.path(getwd(), "UCI HAR Dataset/train/X_train.txt"), header = FALSE)
    y_train <- read.table(file.path(getwd(), "UCI HAR Dataset/train/y_train.txt"), header = FALSE)
    subject_train <- read.table(file.path(getwd(), "UCI HAR Dataset/train/subject_train.txt"), header = FALSE)

    # Joining information with activity
    y_train$V1 <- activity_labels[y_train$V1, 2]

    # Rename columns
    names(x_train) <- features$V2
    names(y_train) <- "activity"
    names(subject_train) <- "idsubject"

    # Joining all the train information
    train <- cbind(subject_train, y_train, x_train)

    # Joining test and train information
    train_test <- rbind(test, train)

    # Filtering std and mean column names
    filter_data <- grepl("idsubject|activity|mean\\(\\)|std\\(\\)", names(train_test))
    train_test_filter <- train_test[filter_data]

    # Rename columns with appropriately labels
    names(train_test_filter) <- gsub("^t", "time", names(train_test_filter))
    names(train_test_filter) <- gsub("^f", "frequency", names(train_test_filter))
    names(train_test_filter) <- gsub("Acc", "accelerometer", names(train_test_filter))
    names(train_test_filter) <- gsub("Gyro", "gyroscope", names(train_test_filter))
    names(train_test_filter) <- gsub("\\(|\\)|-", "", names(train_test_filter))
    names(train_test_filter) <- gsub("BodyBody", "body", names(train_test_filter))
    names(train_test_filter) <- gsub("Body", "body", names(train_test_filter))

    # Save the information to a file
    write.table(train_test_filter, file = "train_test_filter.txt", row.names = FALSE, col.names = FALSE, sep=",")

    # Group by Subject and Activity
    train_test_group <- group_by(train_test_filter, idsubject, activity)

    # Average of each variable 
    tidy_data <- summarise_each(train_test_group, list(mean))

    # Save the information to a file
    write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE, col.names = FALSE, sep=",")

}
