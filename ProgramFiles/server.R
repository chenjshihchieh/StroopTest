#server.R

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
      fluidRow(actionButton("config", img(src = file.path("icons", "gearicon_small.png"), width = "20px", height = "20px", alt = "Configuration Button"))),
      fluidRow(img(src = file.path("icons", "kpuLogo.jpg"), width = "100%", height = "25%", align = "center", alt = "KPU Logo"))
    )
      
    ##Consent Form?
    ##The stroop test itself
    ##End of test message
    ##Maybe the score
    ##Option for closing the window
      
  })
    
  
}