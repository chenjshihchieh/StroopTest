#Loading in necessary packages and downloading them if necessary
necessary_packages <- c("shiny")
for(i in necessary_packages){
  if(!require(i, character.only = TRUE)){
    install.packages(i)
    require(i, character.only = TRUE)
  }
}

rm(i, necessary_packages)

####Server side for calculating and managing displays
function(input, output){
  
  ###The input the dynamic display
  output$main.display <- renderUI ({
    ## Front page -- A large logo for KPU.
    #insert Kwantlen logo
    list(
      #A button on the top right for some basic configurations: type of task, number of questions, Demographic Info or no. 
      fluidRow(
        list(column(4), column(4),
          column(4, 
                 actionButton("config", 
                              img(src = file.path("icons", "gearicon_small.png"),
                                               width = "20px", height = "20px")
                              )
                 )
             ), offset = 5
               ),
      
      
      fluidRow(
        column(1),
        img(src = file.path("icons", "kpuLogo.jpg"), align = "center")
        ),
    
    #A button on the bottom of the page for continue
      fluidRow(
        column(1),
        actionButton("continue", h2("Start"), align = "center", width = "400px")
        )
    
    )
    
    
    ##Consent Form?
    
    ##The stroop test itself
    
    ##End of test message
    
    ##Maybe the score
    
    ##Option for closing the window
  })
  
  
}