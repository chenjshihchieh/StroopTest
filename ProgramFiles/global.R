#### Load in the necessary elements

#Load in the configuration file
config <- read.csv(file.path("www", "config.csv"))
#Saving parameters to variables
testType <- config[config$parameter == "testType", 2]
conQs <- config[config$parameter == "congruentQuestions", 2]
inconQs <- config[config$parameter == "incongruentQuestions", 2]
ConsentForm <- config[config$parameter == "showConsentForm", 2]

#Configuration choices
config.choices <- list.files("www/")[!str_detect(list.files("www/"), ".csv|.css|icons")]


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
