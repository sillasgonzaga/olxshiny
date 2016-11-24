### ANOTACOES
# O MELHOR METODO PARA CALCULAR A DISTANCIA É vincent.sphere pq é mais rápido e a precisão é a mesma


server = function(input, output, session){
  
  #mylocation <- eventReactive()
  
  #mylocation <- eventReactive(input$go, {geocode(input$userlocation)})
  
  #browser()
  output$mymap <- renderLeaflet({
    map <- leaflet() %>%
    addTiles() %>%
    addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
    # coordenadas de um ponto em específico
    addMarkers(lat = -22.911872, lng = -43.230184,
               popup = "Estádio do Maracanã! <br> Apenas um exemplo!") %>%
    
   # addMarkers(lat = mylocation()$lat, lng = mylocation()$lon) %>%
      
      # adicionar marker inserido pelo usuario  
    #addMarkers(lat = mylocation[1, 2], lng = mylocation[1, 1]) %>%
      
    #addMarkers(lng = -43.183447, lat = -22.913912) %>% 
    # plotar apartamentos
    addCircleMarkers(data = df.apt,
                     lng = ~lon, lat = ~lat,
                     color = ~vetorCoresApt(preco),
                     opacity = 1.5,
                     popup = textoPopup(df.apt, "apartamento"),
                     # Definir nome do grupo para ser usado na camada
                     group = "Apartamentos") %>%
    # plotar quartos
    addCircleMarkers(data = df.quartos,
                     lng = ~lon, lat = ~lat,
                     color = ~vetorCoresQuarto(preco),
                     opacity = 1.5,
                     popup = textoPopup(df.quartos, "quarto"),
                     group = "Quartos") %>%
    addLayersControl(
      overlayGroups = c("Apartamentos", "Quartos"),
      options = layersControlOptions(collapsed = FALSE),
      position = "bottomright"
    ) %>%
    addLegend(pal = vetorCoresApt, values = df.apt$preco,
              position = "bottomright")
    map
  })
  
  #leafletProxy("mymap", session) %>% addMarkers(lng = v$lon,lat = v$lat)
 
  
   observeEvent(input$go, {
     v <- geocode(input$userlocation)
     leafletProxy('mymap', session) %>% addMarkers(lng = v$lon,lat = v$lat)
   })
  
  
}