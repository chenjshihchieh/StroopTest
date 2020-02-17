#ui.R

####What participants see
fluidPage(
  useShinyjs(),
  
  actionButton("config", img(src = file.path("icons", "gearicon_small.png"), width = "20px", height = "20px", alt = "Configuration Button"), align = "right"),
  #A changing display based on a button input value
  uiOutput('main.display', align = "center"),
  #A button on the bottom of the page for starting the stroop test
  actionButton(inputId = "start", label = h2("Start"), align = "center", width = "200")
)
