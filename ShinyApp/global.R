#### Load in the necessary elements
#Loading in necessary packages and downloading them if necessary
library(shiny)
library(shinyjs)
library(stringr)

#Load in the configuration file
configuration <- read.csv(file.path("www", "config.csv"), stringsAsFactors = FALSE)
#Saving parameters to variables
testType <- configuration[configuration$parameter == "testType", 2]
conQs <- as.numeric(configuration[configuration$parameter == "congruentQuestions", 2])
inconQs <- as.numeric(configuration[configuration$parameter == "incongruentQuestions", 2])
animalSelection <- configuration[configuration$parameter == "animalSelection", 2]
animalSelect <- unlist(str_split(animalSelection, "-"))
stroopAnimal_csv <- read.csv(file.path("www", "stroopAnimal.csv"), stringsAsFactors = FALSE)

animalList <- unique(stroopAnimal_csv$Word)

totQs <- conQs + inconQs


#Configuration choices
config.choices <- list.files("www/")[!str_detect(list.files("www/"), ".csv|.css|icons")]

##Creating the dataframe for entering the data
readWordsDat <- data.frame(
  conCorrect = 0, inconCorrect = 0,
  totalCorrect = 0, numOfConQs = 0,
  numOfInconQs = 0, totalNumOfQs = 0
)

readImagesDat <- data.frame(
  conCorrect = 0, inconCorrect = 0,
  totalCorrect = 0, numOfConQs = 0,
  numOfInconQs = 0, totalNumOfQs = 0
)