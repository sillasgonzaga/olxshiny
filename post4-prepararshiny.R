# script de preparar mapa para plotar no shiny
library(RColorBrewer)

# dados
df.apt <- read.csv2("post4-df.apt-tratado.csv", stringsAsFactors = FALSE)
df.quartos <- read.csv2("post4-df.quartos-tratado.csv", stringsAsFactors  = FALSE)

# criar palette para colorir os pontos no mapa: verde significa aluguel baixo, vermelho aluguel caro
intervalo <- seq(0, 3200, 400)
palette_rev <- rev(brewer.pal(length(intervalo), "RdYlGn"))
# O vetor de cores é criado com a função colorBin
vetorCoresApt <- colorBin(palette_rev, domain = df.apt$preco, bins = intervalo, na.color = "black")
vetorCoresQuarto <- colorBin(palette_rev, domain = df.quartos$preco, bins = intervalo, na.color = "black")

# Criar função para exibir texto ao clicar em um imóvel
html_link <- function(link) paste0('<a href="', link, '">Link</a>')

textoPopup <- function(data, tipo) {
  # tipo = quarto ou Apartamento
  if (!tipo %in% c("apartamento", "quarto")) stop("Input errado.")
  x = paste0(
    "Tipo do imóvel: ", tipo, "<br>",
    "Url: ", html_link(data$link), "<br>",
    "Título: ", data$titulo, "<br>",
    "Preço: R$", data$preco, "<br>"
  )
  
  if (tipo == "apartamento") {
    x = paste0(
      x,
      "Condomínio: R$", data$taxa_condominio, "<br>",
      "Quartos: ", data$qtd_quarto, "<br>",
      "Área (m²): ", data$area_condominio, "<br>",
      "Garagem: ", data$garagem, "<br>"
    )
  }
  return(x)
}
# 
# map <- leaflet() %>%
#   addTiles() %>%
#   addProviderTiles("OpenStreetMap.BlackAndWhite") %>%
#   # coordenadas de um ponto em específico
#   addMarkers(lat = -22.911872, lng = -43.230184,
#              popup = "Estádio do Maracanã! <br> Apenas um exemplo!") %>%
#   #addMarkers(lng = -43.183447, lat = -22.913912) %>% 
#   # plotar apartamentos
#   addCircleMarkers(data = df.apt,
#                    lng = ~lon, lat = ~lat,
#                    color = ~vetorCoresApt(preco),
#                    opacity = 1.5,
#                    popup = textoPopup(df.apt, "apartamento"),
#                    # Definir nome do grupo para ser usado na camada
#                    group = "Apartamentos") %>%
#   # plotar quartos
#   addCircleMarkers(data = df.quartos,
#                    lng = ~lon, lat = ~lat,
#                    color = ~vetorCoresQuarto(preco),
#                    opacity = 1.5,
#                    popup = textoPopup(df.quartos, "quarto"),
#                    group = "Quartos") %>%
#   addLayersControl(
#     overlayGroups = c("Apartamentos", "Quartos"),
#     options = layersControlOptions(collapsed = FALSE),
#     position = "bottomright"
#   ) %>%
#   addLegend(pal = vetorCoresApt, values = df.apt$preco,
#             position = "bottomright")
