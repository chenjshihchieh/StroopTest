#ui.R

####What participants see
fluidPage(
  #A changing display based on a button input value
  uiOutput('main.display'),
  #A button on the bottom of the page for starting the stroop test
  actionButton(inputId = "start", label = h2("Start"), align = "center", width = "400px")
)
