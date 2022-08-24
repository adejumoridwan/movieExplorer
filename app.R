library(shiny)
library(tidyverse)
library(ggplot2movies)

dataset <- movies

ui <- fluidPage(
  pageWithSidebar(
    headerPanel("Movie Explorer"),
    
    #Side bar Panel
    sidebarPanel(
      
      #slider inputs (year and rating)
      sliderInput(inputId = "year", label = "Year", min = 1893, max = 2005, value = c(1960,2005),step = 1),
      sliderInput(inputId = "rating", label = "Rating", min = 1, max = 10, value = c(6,10),step = 0.1),
      
      h4("Genres"),
      
      #checkbox inputs 
      checkboxInput(inputId = "action", label = "Action", value = FALSE),
      checkboxInput(inputId = "animation", label = "Animation", value = FALSE),
      checkboxInput(inputId = "comedy", label = "Comedy", value = FALSE),
      checkboxInput(inputId = "drama", label = "Drama", value = FALSE),
      checkboxInput(inputId = "documentary", label = "Documentary", value = FALSE),
      checkboxInput(inputId = "romance", label = "Romance", value = FALSE),
      checkboxInput(inputId = "short", label = "Short", value = FALSE)
    ),
    
    #main panel
    mainPanel(
      tableOutput("movie_titles")
    )
  )
)

server <- function(input, output, session) {
  
  output$movie_titles = renderTable({
    dataset |> 
      filter(between(year, input$year[1],input$year[2]),
             between(rating, input$rating[1],input$rating[2]),
             Action == input$action,
             Animation == input$animation,
             Comedy == input$comedy,
             Drama == input$drama,
             Documentary == input$documentary,
             Romance == input$romance,
             Short == input$short) |> 
      select(title) |> 
      rename(title, Movies = title)
  })
}

shinyApp(ui, server)

