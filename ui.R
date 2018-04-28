library(dplyr)
library(magrittr)
library(tidyr)
library(shiny)
library(leaflet)


# Shiny UI
ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  
  # slider panel
  absolutePanel(
    id = 'controls',
    class = 'panel panel-default',
    fixed = T,
    height = 'auto',
    top=50,
    right = 50,
    left = 'auto',
    bottom = 'auto',
    width = 'auto', 
    draggable = T,
    selectInput('map', "Map Type", choices = c( 
      "CartoDB.Positron",
      "Esri.WorldImagery"), 
      selected = "CartoDB.Positron"),
    sliderInput(
      "range",
      "year Range",
      min=min(df$year),
      max = max(df$year),
      value = range(df$year),
      step=1
    )
  )
  
)