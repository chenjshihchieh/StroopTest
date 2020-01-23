#### Load in the necessary elements

#Load in the configuration file
config <- read.csv(file.path("www", "config.csv"))
#Saving parameters to variables
testType <- config[config$parameter == "testType", 2]
conQs <- config[config$parameter == "congruentQuestions", 2]
inconQs <- config[config$parameter == "incongruentQuestions", 2]
ConsentForm <- config[config$parameter == "showConsentForm", 2]



#Load in a data table that contains question information:
#Category(Congruent/Incongruent), Filepath to image, image file name, Word of stimuli, image of stimuli
#Load in a different csv file depending on the test type
if(testType == 1){
questioninfo <- read.csv(file.path("www", "stroopInfo.csv"), stringsAsFactors = FALSE)
}else if (testType == 2){
  return()
}

#Loading in previous participant data
#If none are present, create a new one
datapath <-file.path("..", "StroopData.csv")
if(file.exists(datapath)){
  data <- read.csv(datapath, stringsAsFactors = FALSE)
  rm(datapath)
}else{

  data <- (
    function(){
    PID <- ""
    Word <- ""
    Colour <- ""
    ReactTime <- ""
    Condition <- ""
    Response <- ""
    Correct <- ""
    
    dat <- data.frame(PID, Word, Colour, ReactTime, Condition, Response, Correct)
    return(dat)
    }
  )()
  
}
