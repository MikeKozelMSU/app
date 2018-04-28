library(dplyr)
library(magrittr)
library(tidyr)
library(shiny)
library(leaflet)

# SHiny server
server <- function(input, output, session) {
  filteredData <- reactive({
    df[df$year >= input$range[1] & df$year <= input$range[2],]
  })
  
  # Map output
  output$map <- renderLeaflet({
    leaflet(df) %>%
      fitBounds(~min(longitude), ~min(latitude), ~max(longitude), ~max(latitude)) %>%
      addProviderTiles(input$map)
  })
  
  
  # plot points on the map
  observe({
    
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>% clearPopups() %>% clearMarkers() %>% clearMarkerClusters() %>% 
      addCircleMarkers(lng=~longitude, lat=~latitude, popup = ~paste(paste("<h3>", filteredData()$conflict_name, "</h3>"), 
                                                                     paste("<b>Side A:</b>", side_a, "<br>", "<b>Side B:</b>", side_b, "<br>",
                                                                           "<b>Date:</b>", paste(date_start, date_end, sep = " - "), '<br>', "<b>Casualties:</b>", best , sep = " ")),
                       clusterOptions = markerClusterOptions())
  })
  
}
