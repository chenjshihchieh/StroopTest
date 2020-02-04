#server.R

####Server side for calculating and managing displays
function(input, output){
  rv <- reactiveValues(transition = 0, 
                       configuration = FALSE,
                       Qnumber = 1,
                       initialTime = Sys.time(),
                       endTime = Sys.time()
                       )
  
  ###The input the dynamic display
  #rv$transition == 0 is the front page
  #rv$transition == 1 is the instruction page; consent form can be added if necessary but need to adjust rv$transition in consequent if statement
  #rv$transion > 1 is the task itself.
  #rv$Qnumber will deterimine which question is displayed
  output$main.display <- renderUI ({
    
    if(rv$transition == 0 & !rv$configuration){
    ## Front page -- A large logo for KPU.
    #insert Kwantlen logo
    list(
      #A button on the top right for some basic configurations: type of task, number of questions, Demographic Info or no. 
      
      img(src = file.path("icons", "kpuLogo.jpg"), 
          width = "100%", 
          height = "25%", 
          align = "center", 
          alt = "KPU Logo")
    )
    }else if(rv$configuration){
      
    ##Configuration page for varios test configurations
      #Radio buttons for the various stroop choices
      list(radioButtons("testChoices", "Select the type of Stroop:", 
                        choices = config.choices, 
                        inline = TRUE),
      #Number of congruent questions
           numericInput("congruentQs", "Number of Congruent Questions", 25),
      
      #Number of incongruent questions
           numericInput("incongruentQs", "Number of Incongruent Questions", 25),
           actionButton("save", "Save")
           )
    }else if(rv$transition == 1){
        list(h2("Please try to identify the colour of the word then click on the appropriate button."),
                h2("Please try to ignore the word itself and focus on the colour of the word."))
    
    }else if(rv$Qnumber >= 1 & rv$Qnumber <= conQs + inconQs){
      ##The stroop test itself    
      list(
        fluidRow(column(2),
                 column(1, h3(paste("Question", rv$Qnumber), align = "left")),
                 column(9)),
        fluidRow(
          column(3),
          column(6,
          imageOutput("stroopImage", width = "50%", height = "200px"),
          ),
          column(3)
        ),
        
        fluidRow(
          column(3),
          column(6,
                 actionButton("red", "Red", style = "position: relative; top: 0px;"),
                 actionButton("blue", "Blue", style = "position: relative; top: 0px;"),
                 actionButton("yellow", "Yellow", style = "position: relative; top: 0px"),
                 actionButton("green", "Green", style = "position: relative; top: 0px")),
          column(3)
        )
      )
    }else if(rv$Qnumber > conQs + inconQs){
        list(
          h1("You are done!"),
          tableOutput("reactTable"),
          tableOutput("reactTable2"),
          tableOutput("resultsTable")
             )
      }

    
    ##End of test message
    ##Maybe the score
    ##Option for closing the window
      
  })
  
  ##Setting up the events for transitioning different pages
  #Transitioning to the configuration page
  observeEvent(input$config, rv$configuration <- !rv$configuration)

  #General transition to different pages
  observeEvent(input$start, {
    rv$initialTime <- Sys.time()
    rv$transition <- rv$transition +1
    
    
  })
  
  #Transitioning throught the stroop questions
  #Making sure that each actionbutton will progress the questions and save the response
  #Making sure that the action button will also append the required data to the saved_dat data frame
  observeEvent(input$red, {
    response <- "Red"
    resCorrect <- question_pool$Colour[rv$Qnumber] == response
    saved_dat$totalCorrect <<- saved_dat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      saved_dat$conCorrect <<- saved_dat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      saved_dat$inconCorrect <<- saved_dat$inconCorrect + resCorrect
    }
    
    rv$endTime <- Sys.time()
    reactTime$Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
    
  })
  observeEvent(input$blue, {
    response <- "Blue"
    resCorrect <- question_pool$Colour[rv$Qnumber] == response
    saved_dat$totalCorrect <<- saved_dat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      saved_dat$conCorrect <<- saved_dat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      saved_dat$inconCorrect <<- saved_dat$inconCorrect + resCorrect
    }
    rv$endTime <<- Sys.time()
    reactTime$Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  observeEvent(input$yellow, {
    response <- "Yellow"
    resCorrect <- question_pool$Colour[rv$Qnumber] == response
    saved_dat$totalCorrect <<- saved_dat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      saved_dat$conCorrect <<- saved_dat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      saved_dat$inconCorrect <<- saved_dat$inconCorrect + resCorrect
    }
    
    rv$endTime <<- Sys.time()
    reactTime$Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  observeEvent(input$green, {
    response <- "Green"
    resCorrect <- question_pool$Colour[rv$Qnumber] == response
    saved_dat$totalCorrect <<- saved_dat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      saved_dat$conCorrect <<- saved_dat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      saved_dat$inconCorrect <<- saved_dat$inconCorrect + resCorrect
    }
    
    rv$endTime <<- Sys.time()
    reactTime$Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  
  ##Hiding various buttons so that it doesn't show up in places that it shouldn't
  observe({
    if(input$start > 0 | rv$configuration) {
      shinyjs::hide("config")
    }else if(input$start == 0 & !rv$configuration){
        shinyjs::show("config")
      }
  })
  observe({
    if(input$start > 1|rv$configuration) {
      shinyjs::hide("start")
      }else if(input$start > 1|!rv$configuration)shinyjs::show("start")
  })
  
  ###Configurations Functions
  ##Something to trigger when the saved button is pressed
 
  observeEvent(input$save, {
    #testChoices saved to testType
    testType <<- input$testChoices
    
    #CongruentQs saved to conQs
    conQs <<- input$congruentQs
    
    #incongruentQs saved to inconQs
    inconQs <<- input$incongruentQs
    
    #Pressing the save button will save the configuration to config.csv
    newValues <<- c(testType, conQs, inconQs, 0)
    configuration$values <<- newValues
    write.csv(configuration, file.path("www", "config.csv"), row.names = FALSE)
    rv$configuration <- !rv$configuration
  })

  ##Reading information for the relevant questions
  #Load in a data table that contains question information:
  #Category(Congruent/Incongruent), Filepath to image, image file name, 
  #Word of stimuli, image of stimuli
  #Load in a different csv file depending on the test type
  observe({
    value <- input$start
    if(value == 1){
      questionInfo <<- read.csv(file.path("www", "stroopWord.csv"), stringsAsFactors = FALSE)
      
      ### Creating a randomized series of questions and saving them
      #Pull out the index where the congruent images are at
      congruentIndex <- str_which(questionInfo$Category, "Congruent")
      
      #Pull out the index where the incongruent images are at
      incongruentIndex <- str_which(questionInfo$Category, "Incongruent")
      
      #Creating a pool of index to randomize from
      index_pool <- c(sample(congruentIndex, conQs, replace = TRUE), 
                         sample(incongruentIndex, inconQs, replace = TRUE))
      
      #Randomizing the congruent and incongruent question index
      questionIndex <- sample(index_pool, conQs + inconQs, replace = FALSE)
      
      #Creating the table
      question_pool <<- questionInfo[questionIndex,]
      
      ##Reaction Time data
      reactTime <<- data.frame(Category = question_pool$Category, Time = rep(NA, conQs+inconQs))
      
      ##Entering some information into saved data
      saved_dat$numOfConQs <<- conQs
      saved_dat$numOfInconQs <<- inconQs
      saved_dat$totalNumOfQs <<- conQs + inconQs
      
    }
  })
  

  output$reactTable <- renderTable({
    unused <- input$red
    unused1 <- input$blue
    unused2 <- input$yellow
    unused3 <- input$green
    reactTime
  })
  
  output$reactTable2 <- renderTable({
    unused <- input$red
    unused1 <- input$blue
    unused2 <- input$yellow
    unused3 <- input$green
    data.frame(
      conTime = mean(reactTime$Time[reactTime$Category == "Congruent"], na.rm = TRUE),
      inconTime = mean(reactTime$Time[reactTime$Category == "Incongruent"], na.rm = TRUE)
    )
  })
  
  output$resultsTable <- renderTable({
    saved_dat
  })
  
  # This generates the image based on the current question
  output$stroopImage <- renderImage({
    files_list <- paste(testType, question_pool$Paths[rv$Qnumber], question_pool$Images[rv$Qnumber])
    files_split <- unlist(str_split(files_list, " ", n = 4))
    image.path <- file.path("www", files_split[1], files_split[2], files_split[3], files_split[4])
    list(src = image.path, border = "0")
    }, deleteFile = FALSE)


  
  
}
  
    
