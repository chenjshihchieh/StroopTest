#Loading in necessary packages and downloading them if necessary
necessary_packages <- c("shiny", "shinyjs", "stringr")
for(i in necessary_packages){
  if(!require(i, character.only = TRUE)){
    install.packages(i)
    require(i, character.only = TRUE)
  }
}

rm(i, necessary_packages)

runApp()