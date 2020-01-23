#Loading in necessary packages and download them if not availabe
necessary_packages <- c("magick", "dplyr", "stringr")

for(i in necessary_packages){
  if(!require(i, character.only = TRUE)){
    install.packages(i)
    require(i, character.only = TRUE)
  }
}

rm(necessary_packages, i)

###Setting working directory
#Choosing the location of a file that the directory is in
fileDirectory <- file.choose()
#file name pattern
pattern <- "\\w*\\.png"
#removing the name of the file itself to retain the desired directory
workingdirectory <- str_replace(fileDirectory, pattern = pattern, "")
#changing the working direcotry
setwd(workingdirectory)
#Extract the list of images
images <- list.files()

####Loop through the images to resize and save each image individually
for(i in images) { #remove the "[1]" after testing

#read in the image
  image <- image_read(i)  

###Resizing the image
  croppedImage <- image_crop(image, "120x80-260-25")
  print(croppedImage)
###Saving the resized image
#attach the word 'resized-' to the image name
  savingName <- paste0("resized-", i)
#save the image under the new image name
  image_write(croppedImage, paste0(savingName))
}
