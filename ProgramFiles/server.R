#server.R

####Server side for calculating and managing displays
function(input, output){
  rv <- reactiveValues(transition = 0, 
                       configuration = FALSE,
                       Qnumber = 1
                       )
  
  ###The input the dynamic display
  
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
      list(radioButtons("configChoices", "Select the type of Stroop:", 
                        choices = config.choices, 
                        inline = TRUE),
      #Number of congruent questions
           numericInput("congruentQs", "Number of Congruent Questions", 25),
      
      #Number of incongruent questions
           numericInput("incongruentQs", "Number of Incongruent Questions", 25),
           actionButton("save", "Save")
           )
    }else if(rv$transition == 1){
        list(h2("Where the stroop test starts, Some instructions for the test"))
    
    }else if(rv$transition > 1){
      ##The stroop test itself    
      list(
        
        actionButton("red", "Red"),
        actionButton("blue", "Blue"),
        actionButton("yellow", "Yellow"),
        actionButton("green", "Green")
      )
      }

    
    ##End of test message
    ##Maybe the score
    ##Option for closing the window
      
  })
  
  ##Setting up the events for transitioning different pages
  #Transitioning to the configuration page
  observeEvent(input$config, rv$configuration <- !rv$configuration)
  observeEvent(input$save, {
    testType <- input$configChoices
    conQs <- input$congruentQs
    inconQs <- input$incongruentQs
    rv$configuration <- !rv$configuration
    })
  #General transition to different pages
  observeEvent(input$start, rv$transition <- rv$transition +1)
  #Transitioning throught the stroop questions
  #Making sure that each actionbutton will progress the questions and save the response
  observeEvent(input$red, {
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
  })
  observeEvent(input$blue, {
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
  })
  observeEvent(input$yellow, {
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
  })
  observeEvent(input$green, {
    rv$transition <- rv$transition + 1
    rv$Qnumber <- rv$Qnumber + 1
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
  
  ##Reading information for the relevant questions
  #Load in a data table that contains question information:
  #Category(Congruent/Incongruent), Filepath to image, image file name, 
  #Word of stimuli, image of stimuli
  #Load in a different csv file depending on the test type

  
  # This generates the image based on the current question

  
  #### Render functions for output elements other than UI rendering
  ## Creating the element to allow transition() function to be called
}
  
    
