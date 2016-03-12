## INTRODUCTION

In this repository there will be located  all needed files to cover the main objective of first week lesson.

The idea is to show a compiled HTML file produced from some processing code of the data imported in the file repdata-data-activity.zip, which is also provided for own verification and reproducible analisys.


## DATA

List of files provided

- activity.csv
- repdata-data-activity.zip
- TotalStepsDay_Imputted.png
- ActivityPattern.png
- AvgStepsDay.png
- TotalStepsDay.png
- C5_Project1.R
- PA1_Template.Rmd
- PA1_Template.html

From the orginal source:

The data for this assignment can be downloaded from the course web site:

Dataset: Activity monitoring data [52K]

The variables included in this dataset are:

 * steps: Number of steps taking in a 5-minute interval (missing values are coded as NA)

 * date: The date on which the measurement was taken in YYYY-MM-DD format

 * interval: Identifier for the 5-minute interval in which measurement was taken

The dataset is stored in a comma-separated-value (CSV) file and there are a total of 17,568 observations in this dataset


## ASSIGNMENT

The way to complete the assignment is to get the raw data  imported into a dataset with the information provided on file "repdata-data-activity.zip"

In a first stage, Missing Values will be ignored and with the resulting information code was done in order to get some plots to answer the following questions:

1. What is mean total number of steps taken per day?
2. What is the average daily activity pattern?

On the second stage, missing values were included to get a new analisys. The method to fill all missing values is based on sampling the information gotten in the variable "steps"" for the new dataset. So from the sample, valid values were used to fill missing information

Under this escenario the following questions were addressed:

3. Calculate and report the total number of missing values in the dataset

        * 3a. Make a histogram of the total number of steps taken each day and Calculate and report the mean and median total number of steps taken per day
        
        * 3b. Do these values differ from the estimates from the first part of the assignment?
        
        * 3c. What is the impact of imputing missing data on the estimates of the total daily number of steps?
        

4. Are there differences in activity patterns between weekdays and weekends?


For question number 1, plotting was conducted using base package, histogram was done by getting the sum of all steps by day.

For question 2, a resulting dataframe was done based on the average of steps by 5-min interval. Thus the pattern shown from this information is produced into a plot whit base package. From graphic, it is clear that interval 835 is the one showing the highest amount of steps along the interval range.

For question 3a, total number of missin values is 2304, which seems to be not that representative from the whole observations of variable "steps"(17568)

For question 3b and 3c the histogram shows a small increment in the amount of steps by day, but still keeping most cases of total steps by day in the range of 10k-15k, so filling the mising values did not make the bias to dramatic.

Finally, from plot on question 4, pattern shows more increment of steps during weekend vs the timeline of intervals. Just for simple aestethic matter the same inrmation is plotted using lettice and ggplot2 packages.

