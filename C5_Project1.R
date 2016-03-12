################################################################################
# This code is intended to cover the assignment for Project 1 on Course 5 of
# Data Scientist Specialization
#
################################################################################
# Loading needed libraries
library(dplyr)
library(ggplot2)
library(lattice)
## Loading the Data
setwd("/Users/elobo/HomeRstudio/Curso5")
DataIn <- read.csv(unz("repdata-data-activity.zip", "activity.csv"),sep=",",na.strings = "NA")
## Cleaning missing values:
DataIn <- DataIn[complete.cases(DataIn),]

## Question 1. What is mean total number of steps taken per day?
        TotalSteps <- tapply(DataIn$steps, DataIn$date, sum)
        TotalSteps <- data.frame("steps" = TotalSteps[complete.cases(TotalSteps)])
        TotalSteps$date <- as.Date(rownames(TotalSteps))

        #Calculating mean of total steps by day
        mean(TotalSteps$steps)

        #Calculating median of total steps by day
        median(TotalSteps$steps)
        # Making histogram into a file
        png("TotalStepsDay.png", width = 580, height = 580)
        hist(TotalSteps$steps, main = paste("Histogram of Distribution of total steps"), xlab = "Range of steps", breaks=20)
        abline(v = mean(TotalSteps$steps), col="red", lw="3")
        abline(v = median(TotalSteps$steps), col="blue", lw="1")
        dev.off()
        


### Question 2. What is the average daily activity pattern?

        avg_by_inter <- data.frame("interval"=row.names(tapply(DataIn$steps, DataIn$interval, mean, na.rm=T)), "steps"=tapply(DataIn$steps, DataIn$interval, mean, na.rm=T),stringsAsFactors = FALSE)
    
        ## Getting the plot for avg daily pattern
        png("AvgStepsDay.png", width = 580, height = 580)
        with(avg_by_inter, plot(interval, steps, type = "l",
                                xlab = "5-min interval", 
                                ylab = "Number of steps - avg",
                                main = "Average daily number of steps", 
                                col = "red"))
        dev.off()
        

        ## Which 5-minute interval, on average across all the days in the dataset, 
        ## contains the maximum number of steps?
        
        # checks for the max avg value, then look for all interval in that day
        subset(avg_by_inter, steps==max(avg_by_inter$steps)) 
        
        ## A: 
                #interval    steps
                #835         206.1698


### Question 3. Imputing missing values
        ## Getting dataset with missing values
        DataIn <- read.csv(unz("repdata-data-activity.zip", "activity.csv"),sep=",",na.strings = "NA")
        Total_NA <- sum(is.na(DataIn$steps))
        message("Total Missing values in dataset is: ", Total_NA)

        ## Filling in Missing Values into a new dataset

        NewDataIn <- DataIn
        ## getting sample of correct values of steps and then assign it to all NAs
        fillna <- sample (DataIn$steps[!is.na(DataIn$steps)], Total_NA, replace=TRUE) 
        NewDataIn$steps[is.na(DataIn$steps)] <- fillna
        
        # Total steps by day
        TotalSteps2 <- tapply(NewDataIn$steps, NewDataIn$date, sum)
        TotalSteps2 <- data.frame("steps" = TotalSteps2)
        TotalSteps2 <- mutate(TotalSteps2, date=as.Date(rownames(TotalSteps2)))

        # Make a histogram of the total number of steps taken each day and Calculate and 
        # report the mean and median total number of steps taken per day.
        png("TotalStepsDay_Imputted.png", width = 580, height = 580)
        hist(TotalSteps2$steps, main = paste("Histogram of Distribution of total steps"), xlab = "Range of steps", breaks=20)
        abline(v = mean(TotalSteps2$steps), col="red", lw="3")
        abline(v = median(TotalSteps2$steps), col="blue", lw="1")
        dev.off()


        ## Do these values differ from the estimates from the first part of the assignment? 
        # A: yes.
        
        ## What is the impact of imputing missing data on the estimates of the total daily number of steps?
        # A: there is an increase in the total steps, however the distribution seems to keep confined to the same ranges 
        

# Question 5. Are there differences in activity patterns between weekdays and weekends?

        library(lubridate)
        NewDataIn$date <- as.Date(NewDataIn$date)
        NewDataIn$day <- weekdays(NewDataIn$date)
        NewDataIn$day <- wday(NewDataIn$date, label=TRUE)
        
        levels(NewDataIn$day) <- c("weekend", "weekday", "weekday", "weekday", "weekday", "weekday","weekend")
        
        stepsByDay <- aggregate(steps ~ interval + day, data = NewDataIn, mean)
        
        
        ## unsing lattice
        xyplot(steps ~ interval | day, data=stepsByDay, layout=c(1,2), type="l")
     
        ## using ggplot
        png("ActivityPattern.png", width = 680, height = 680)
        g <- ggplot(stepsByDay, aes(interval, steps, colour=day))
        g + geom_line() + facet_grid( . ~ day) + theme_bw()  + labs(x="5-min Interval", y="Avg Steps [#]")
        dev.off()

