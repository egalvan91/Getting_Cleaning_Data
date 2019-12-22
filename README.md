# Getting_Cleaning_Data
## 1) Import Library dplyr
Use the library() function
## 2) Reading files activity_labels and features
Files I will use later. Skipping the header
## 3) Reading files x_test, y_test and subject_test
Also skipping the header
## 4) Joining information with activity
To join the data of y_test with activity_labels
## 5) Rename columns
Rename the columns Vn to those corresponding to each data set
## 6) Joining all the test information
With the subject test, activity test and x_test data, it generates the "test" dataframe using the cbind () function.
## 7) I repeated steps 3 through 6 for train data
## 8) Joining test and train information
Use the rbind() function
## 9) Filtering std and mean column names
using the grepl () function, save a filter for the data that matters
## 10) Rename columns with appropriately labels
Replace what started with "t" by "time"
Replace what started with "f" by "frequency"
Replace "Acc" by "accelerometer"
Replace "Gyro" by "gyroscope"
Replace the symbol "(", ")" and - by empty
Replace "BodyBody" by "body"
Replace "Body" by "body"
## 11) Save the information to a file
The file name is train_test_filter.txt
## 12) Group by Subject and Activity
Use the group_by() function
## 13) Average of each variable 
use the summarise_each() function
## 14) Save the information to a file
The file name is tidy_data.txt
# End
