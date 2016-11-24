# ui
library(leaflet)
library(shiny)
library(ggmap)


source("post4-prepararshiny.R")


 ui = bootstrapPage(
   div(class = "outer",
       tags$head(
         # Include our custom CSS
         includeCSS("styles.css"),
         includeScript("gomap.js")
       ),
       
   tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
   leafletOutput("mymap", width = "100%", height = "100%"),
   
   absolutePanel(id = "controls",# class = "panel panel-default",
                 fixed = TRUE,
                 draggable = TRUE,
                 top = 60, left = "auto", right = 20, bottom = "auto",
                 width = 330, height = "auto",
                 
                 h2("Buscador OLX"),
                 textInput(inputId = "userlocation",
                           label = "Digite um endereço\n com pelo menos rua, número, bairro e cidade",
                           value = ""),
                 helpText("Exemplo: Rua Dias da Rocha, 85 - Copacabana, Rio de Janeiro - RJ"),
                 
                 sliderInput(inputId = "distancia", label = "Escolha a distância em km:",
                             min = 0, max = 30, value = 15),
                 
                 actionButton("go", "Buscar"),
                 helpText("Encontre imóveis para alugar perto de onde você quiser!"),
                 
                 helpText("Cada ponto no mapa representa um imóvel para alugar.",
                          "A cor de um ponto é determinada pelo valor do aluguel.",
                          "Clique em um ponto para ter mais informações sobre o imóvel."),
                 
                 helpText("Mais informações sobre este app em sillasgonzaga.github.io")

                 )

   ),
   tags$div(id="cite",
            'Dados extraídos do OLX em 12/11/2016.', ' Contato: sillasgonzaga.github.io'
   )
)
