dataDir <- "diet_data/"

## Get a feel for the data
andy <- read.csv(paste0(dataDir, "Andy", ".csv"))
str(andy)
dim(andy)
names(andy)
summary(andy)
head(andy)

## Load multiple data files
files <- list.files(dataDir, full.names = TRUE)

andy_david <- rbind(andy, read.csv(files[2]))
day_25 <- andy_david[which(andy_david$Day == 25), ]
day_25

## Create a big data.frame
dat <- data.frame()
for (i in seq_along(files)) {
  dat <- rbind(dat, read.csv(files[i]))
}

## Embed in a function
weightmedian <- function(directory, day)  {
  files_list <- list.files(directory, full.names=TRUE)   #creates a list of files

  ### The following approach to build 'dat' is sub-optimal but will do fir now
  dat <- data.frame()                             #creates an empty data frame
  for (i in 1:5) {
    #loops through the files, rbinding them together
    dat <- rbind(dat, read.csv(files_list[i]))
  }

  dat_subset <- dat[which(dat[, "Day"] == day),]  #subsets the rows that match the 'day' argument
  median(dat_subset[, "Weight"], na.rm=TRUE)      #identifies the median weight
                                                  #while stripping out the NAs
}

weightmedian(directory = "diet_data", day = 20)
weightmedian("diet_data", 4)
weightmedian("diet_data", 17)
