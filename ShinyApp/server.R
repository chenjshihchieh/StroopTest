#server.R

####Server side for calculating and managing displays
function(input, output, session){
  ####Setting up the necessary values
  rv <- reactiveValues(transition = 0, 
                       configuration = FALSE,
                       Qnumber = 1,
                       initialTime = Sys.time(),
                       endTime = Sys.time()
                       
                       )
  
  ####The actions for each button
  ##Setting up the events for transitioning different pages
  #Transitioning to the configuration page
  observeEvent(input$config, rv$configuration <- !rv$configuration)

  #General transition to different pages
  observeEvent(input$start, {
    rv$initialTime <- Sys.time()
    rv$transition <- rv$transition + 1
  })
  
  ##Configurations Functions
  observeEvent(input$save, {
    testType <<- input$testChoices #testChoices saved to testType
    conQs <<- input$congruentQs #CongruentQs saved to conQs
    inconQs <<- input$incongruentQs #incongruentQs saved to inconQs
    totQs <<- conQs + inconQs
    animalSelect <<- input$questionChoices
    animalSelection <- paste(animalSelect, collapse = "-")
    
    #Pressing the save button will save the configuration to config.csv
    newValues <- c(testType, conQs, inconQs, animalSelection)
    configuration$values <<- newValues
    write.csv(configuration, file.path("www", "config.csv"), row.names = FALSE)
    
    
    #For leaving the configuration page
    rv$configuration <- !rv$configuration
  })
  
  ##Function for four buttons on question page
  #Making sure that each actionbutton will progress the questions and save the response
  #Making sure that the action button will also append the required data to the saved_dat data frame
  observeEvent(input$word1, {
    response <- selection[1]
    resCorrect <- question_pool$Word[rv$Qnumber] == response
    readWordsDat$totalCorrect <<- readWordsDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      readWordsDat$conCorrect <<- readWordsDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      readWordsDat$inconCorrect <<- readWordsDat$inconCorrect + resCorrect
    }
    
    rv$endTime <- Sys.time()
    reactTime$Reaction_Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
    
  })
  observeEvent(input$word2, {
    response <- selection[2]
    resCorrect <- question_pool$Word[rv$Qnumber] == response
    readWordsDat$totalCorrect <<- readWordsDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      readWordsDat$conCorrect <<- readWordsDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      readWordsDat$inconCorrect <<- readWordsDat$inconCorrect + resCorrect
    }
    rv$endTime <<- Sys.time()
    reactTime$Reaction_Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  observeEvent(input$word3, {
    response <- selection[3]
    resCorrect <- question_pool$Word[rv$Qnumber] == response
    readWordsDat$totalCorrect <<- readWordsDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      readWordsDat$conCorrect <<- readWordsDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      readWordsDat$inconCorrect <<- readWordsDat$inconCorrect + resCorrect
    }
    
    rv$endTime <<- Sys.time()
    reactTime$Reaction_Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  observeEvent(input$word4, {
    response <- selection[4]
    resCorrect <- question_pool$Word[rv$Qnumber] == response
    readWordsDat$totalCorrect <<- readWordsDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber] == "Congruent"){
      readWordsDat$conCorrect <<- readWordsDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber] == "Incongruent"){
      readWordsDat$inconCorrect <<- readWordsDat$inconCorrect + resCorrect
    }
    
    rv$endTime <<- Sys.time()
    reactTime$Reaction_Time[rv$Qnumber] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  
  
  #Transitioning throught the stroop questions
  #Making sure that each actionbutton will progress the questions and save the response
  #Making sure that the action button will also append the required data to the saved_dat data frame
  observeEvent(input$image1, {
    response <- selection[1]
    resCorrect <- question_pool$Image[rv$Qnumber-totQs] == response
    readImagesDat$totalCorrect <<- readImagesDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber-totQs] == "Congruent"){
      readImagesDat$conCorrect <<- readImagesDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber-totQs] == "Incongruent"){
      readImagesDat$inconCorrect <<- readImagesDat$inconCorrect + resCorrect
    }
    
    rv$endTime <- Sys.time()
    reactTime2$Reaction_Time[rv$Qnumber-totQs] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
    
  })
  observeEvent(input$image2, {
    response <- selection[2]
    resCorrect <- question_pool$Image[rv$Qnumber-totQs] == response
    readImagesDat$totalCorrect <<- readImagesDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber-totQs] == "Congruent"){
      readImagesDat$conCorrect <<- readImagesDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber-totQs] == "Incongruent"){
      readImagesDat$inconCorrect <<- readImagesDat$inconCorrect + resCorrect
    }
    rv$endTime <<- Sys.time()
    reactTime2$Reaction_Time[rv$Qnumber-totQs] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  observeEvent(input$image3, {
    response <- selection[3]
    resCorrect <- question_pool$Image[rv$Qnumber-totQs] == response
    readImagesDat$totalCorrect <<- readImagesDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber-totQs] == "Congruent"){
      readImagesDat$conCorrect <<- readImagesDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber-totQs] == "Incongruent"){
      readImagesDat$inconCorrect <<- readImagesDat$inconCorrect + resCorrect
    }
    
    rv$endTime <<- Sys.time()
    reactTime2$Reaction_Time[rv$Qnumber-totQs] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  observeEvent(input$image4, {
    response <- selection[4]
    resCorrect <- question_pool$Image[rv$Qnumber-totQs] == response
    readImagesDat$totalCorrect <<- readImagesDat$totalCorrect + resCorrect
    if(question_pool$Category[rv$Qnumber-totQs] == "Congruent"){
      readImagesDat$conCorrect <<- readImagesDat$conCorrect + resCorrect
    }else if(question_pool$Category[rv$Qnumber-totQs] == "Incongruent"){
      readImagesDat$inconCorrect <<- readImagesDat$inconCorrect + resCorrect
    }
    
    rv$endTime <<- Sys.time()
    reactTime2$Reaction_Time[rv$Qnumber-totQs] <<- as.numeric(rv$endTime - rv$initialTime)
    rv$Qnumber <- rv$Qnumber + 1
    rv$initialTime <<- Sys.time()
  })
  
  ##For select choices
  observeEvent(input$testChoices, {
    
  })
  
  ####Hiding various buttons
  #Hiding config icon
  observe({
    if(rv$transition == 0 & !rv$configuration){
      shinyjs::show("config")
    }else if(rv$configuration){
      shinyjs::hide("config")
    }else if(rv$transition >= 1){
      shinyjs::hide("config")
    }
  })
  
  #Hiding start button
  observe({
    if(rv$transition == 0 & !rv$configuration){
      shinyjs::show("start")
    }else if(rv$configuration){
      shinyjs::hide("start")
    }else if(rv$transition == 1){
      shinyjs::show("start")
    }else if(rv$Qnumber >= 1 & rv$Qnumber <= totQs){
      shinyjs::hide("start")
    }else if(rv$transition == 2){
      shinyjs::show("start")
    }else if(rv$Qnumber >= 1+totQs){
      shinyjs::hide("start")
    }
  })

  ####Saving when button pressed
  #Load in a data table that contains question information:
  #Category(Congruent/Incongruent), Filepath to image, image file name, 
  #Word of stimuli, image of stimuli
  #Load in a different csv file depending on the test type
  observe({
    value <- input$start
    if(value == 1){
      if(testType == "stroopWord"){
        selection <<- c("Red", "Blue", "Green", "Yellow")
      }else if(testType == "stroopAnimal"){
        selection <<- animalSelect
      }
      
      ### Creating a randomized series of questions and saving them
      questionDat <- read.csv(file.path("www", paste0(testType, ".csv")), stringsAsFactors = FALSE)
      questionInfo <<- questionDat[questionDat$Word %in% selection & questionDat$Image %in% selection,]
      congruentIndex <- str_which(questionInfo$Category, "Congruent") #congruent images index
      incongruentIndex <- str_which(questionInfo$Category, "Incongruent") #incongruent images index
      #Creating a pool of index to randomize from
      index_pool <- c(sample(congruentIndex, conQs, replace = TRUE), 
                      sample(incongruentIndex, inconQs, replace = TRUE))
      #Randomizing the congruent and incongruent question index
      questionIndex <- sample(index_pool, totQs, replace = FALSE)
      question_pool <<- questionInfo[questionIndex,] #Creating the table
      reactTime <<- data.frame(Category = question_pool$Category, Reaction_Time = rep(NA, totQs)) #Reaction Time data
      
      ##Entering some information into saved data
      readWordsDat$numOfConQs <<- conQs
      readWordsDat$numOfInconQs <<- inconQs
      readWordsDat$totalNumOfQs <<- totQs
      
      
    }
  })
  
  observe({
    value <- input$start
    unused <- input$word1
    unused1 <- input$word2
    unused2 <- input$word3
    unused3 <- input$word4
    if(value == 2 & rv$Qnumber > totQs){
      #Getting randomized question
      congruentIndex <- str_which(questionInfo$Category, "Congruent") #Congruent questions index
      incongruentIndex <- str_which(questionInfo$Category, "Incongruent") #Incongruent questions index
      
      #Creating a pool of index to randomize from
      index_pool <- c(sample(congruentIndex, conQs, replace = TRUE), 
                      sample(incongruentIndex, inconQs, replace = TRUE))
      
      questionIndex <- sample(index_pool, totQs, replace = FALSE) #Randomizing the congruent and incongruent question index
      question_pool <<- questionInfo[questionIndex,] #Creating the table
      
      reactTime2 <<- data.frame(Category = question_pool$Category, Reaction_Time = rep(NA, totQs)) #Reaction Time data
      
      #Entering some information into saved data
      readImagesDat$numOfConQs <<- conQs
      readImagesDat$numOfInconQs <<- inconQs
      readImagesDat$totalNumOfQs <<- totQs
      
    }
  })
  
  ####Rendering the output files
  output$reactTable <- renderTable({
    unused <- input$word1
    unused1 <- input$word2
    unused2 <- input$word3
    unused3 <- input$word4
    reactTime
  })
  
  output$reactTable2 <- renderTable({
    unused <- input$word1
    unused1 <- input$word2
    unused2 <- input$word3
    unused3 <- input$word4
    data.frame(
      conTime = mean(reactTime$Reaction_Time[reactTime$Category == "Congruent"], na.rm = TRUE),
      inconTime = mean(reactTime$Reaction_Time[reactTime$Category == "Incongruent"], na.rm = TRUE)
    )
  })
  
  ###Rendering the output files
  output$reactTable3 <- renderTable({
    unused <- input$word1
    unused1 <- input$word2
    unused2 <- input$word3
    unused3 <- input$word4
    reactTime2
  })
  
  output$reactTable4 <- renderTable({
    unused <- input$word1
    unused1 <- input$word2
    unused2 <- input$word3
    unused3 <- input$word4
    data.frame(
      Average_Congruent_Time = mean(reactTime2$Reaction_Time[reactTime2$Category == "Congruent"], na.rm = TRUE),
      Average_Incongruent_Time = mean(reactTime2$Reaction_Time[reactTime2$Category == "Incongruent"], na.rm = TRUE)
    )
  })
  
  output$resultsTable <- renderTable({
    names(readWordsDat) <- c("Congruent_Correct", "IncongruentCorrect",
                             "Total_Correct", "Number_Of_Congruent_Qs",
                             "Number_Of_Incongruent_Qs", "Total_Qs")
    readWordsDat
  })
  
  output$resultsTable2 <- renderTable({
    names(readImagesDat) <- c("Congruent_Correct", "IncongruentCorrect",
                             "Total_Correct", "Number_Of_Congruent_Qs",
                             "Number_Of_Incongruent_Qs", "Total_Qs")
    readImagesDat
  })
  
  ####File and image generation
  # This generates the image based on the current question
  output$stroopImage <- renderImage({
    image.path <- file.path("www", testType, question_pool$Names[rv$Qnumber])
    list(src = image.path, border = "0")
    }, deleteFile = FALSE)
  
  
  output$stroopImage2 <- renderImage({
    image.path <- file.path("www", testType, question_pool$Names[rv$Qnumber-totQs])
    list(src = image.path, border = "0")
  }, deleteFile = FALSE)

  
  ###Dynamic display
  
  output$main.display <- renderUI ({
    
    ## Front page -- A large logo for KPU.
    if(rv$transition == 0 & !rv$configuration){
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
      list(
        fluidRow(column(4), 
                 column(4, 
                        list(
                          radioButtons("testChoices", "Select the type of Stroop:", 
                                       choices = config.choices,
                                       selected = testType,
                                       inline = TRUE),
                          #Number of congruent questions
                          numericInput("congruentQs", "Number of Congruent Questions", conQs),
                          
                          #Number of incongruent questions
                          numericInput("incongruentQs", "Number of Incongruent Questions", inconQs),
                          
                          
                          #Check mark the questions you want
                          checkboxGroupInput("questionChoices", 
                                             "Select variable for question:", 
                                             animalList, selected = animalSelect, inline = TRUE),
                          actionButton("save", "Save")
                        )), 
                 column(4))
      )
    }else if(rv$transition == 1){
      if(testType == "stroopWord"){
        list(h2("In the first task, you will be shown a series of different coloured words."),
             h2("Please try to ignore the colour of the word and focus on the word itself."),
             h2("For example, if you see the word "), h2("Red", style = "color: blue;"), h2("The answer would be Red"))
      }else if(testType == "stroopAnimal"){
        list(h2("In the first task, you will be showed a series of images with an associated word overlaying the images. "),
             h2("Please try to ignore the images and identify the words themselves."))
      }
      
    }else if(rv$Qnumber >= 1 & rv$Qnumber <= totQs){
      ##The stroop test itself    
      list(
        fluidRow(column(2),
                 column(1, h3(paste("Question", rv$Qnumber), align = "left")),
                 column(9)),
        fluidRow(
          column(3),
          column(6,
                 imageOutput("stroopImage")
          ),
          column(3)
        ),
        
        fluidRow(
          column(3),
          column(6,
                 actionButton("word1", selection[1], style = "position: relative; top: 0px;"),
                 actionButton("word2", selection[2], style = "position: relative; top: 0px;"),
                 actionButton("word3", selection[3], style = "position: relative; top: 0px;"),
                 actionButton("word4", selection[4], style = "position: relative; top: 0px;")),
          column(3)
        )
      )
    }else if(rv$transition == 2){
      if(testType == "stroopWord"){
        list(h2("In the second task, you will be shown a series of different coloured words."),
             h2("Please try to identify the colour of the word and focus on the colour of the word."),
             h2("For example, if you see the word "), h2("Red", style = "color: blue;"), h2("The answer would be Blue"))
      }else if(testType == "stroopAnimal"){
        list(h2("In the first task, you will be showed a series of images with an associated word overlaying the images. "),
             h2("Please try to ignore the words and identify the images themselves."))
      }
    }else if(rv$Qnumber >= 1+totQs & rv$Qnumber <= 2*(totQs)){
      ##The stroop test itself    
      list(
        fluidRow(column(2),
                 column(1, h3(paste("Question", rv$Qnumber), align = "left")),
                 column(9)),
        fluidRow(
          column(3),
          column(6,
                 imageOutput("stroopImage2")
          ),
          column(3)
        ),
        
        fluidRow(
          column(3),
          column(6,
                 actionButton("image1", selection[1], style = "position: relative; top: 0px;"),
                 actionButton("image2", selection[2], style = "position: relative; top: 0px;"),
                 actionButton("image3", selection[3], style = "position: relative; top: 0px;"),
                 actionButton("image4", selection[4], style = "position: relative; top: 0px;")),
          column(3)
        )
      )
    }else if(rv$Qnumber > 2*(totQs)){
      list(
        ##End of test message
        ##Maybe the score
        ##Option for closing the window
        fluidPage(tabsetPanel(
          tabPanel("Reading Word Task", 
                   list(fluidRow(h1("You are done!")), 
                        fluidRow(tableOutput("resultsTable")),
                        fluidRow(column(5), 
                                 column(2, tableOutput("reactTable"),
                                 tableOutput("reactTable2")), column(5))
                        )),
          tabPanel("Identify Image Task", 
                    list(fluidRow(h1("You are done!")),
                         fluidRow(tableOutput("resultsTable2")),
                         fluidRow(column(5), 
                                  column(2, tableOutput("reactTable3"),
                                  tableOutput("reactTable4")), column(5))
                         ))
        ))
        
      )
    }
  })
  session$onSessionEnded(function(){
    stopApp()
  })
}
  
    
