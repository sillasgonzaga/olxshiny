library(leaflet)
library(shiny)

source("post4-prepararshiny.R")

ui = bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("mymap", width = "100%", height = "100%")

)

server = function(input, output) {
  output$mymap = renderLeaflet(map)
  }

shinyApp(ui = ui, server = server)
runApp('post4-shiny.R')
