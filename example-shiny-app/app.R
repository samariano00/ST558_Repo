#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

# Load packages

library(shiny)
library(bslib)
library(ggplot2)

# Get the data

file <- "https://github.com/rstudio-education/shiny-course/raw/main/movies.RData"
destfile <- "movies.RData"

download.file(file, destfile)

# Load data

load("movies.RData")

# Define UI

ui <- page_sidebar(
  sidebar = sidebar(
    # Select variable for y-axis
    selectInput(
      inputId = "y",
      label = "Y-axis:",
      choices = c(
        "IMBD Rating" = "imdb_rating",
        "Number of Votes on IMDB" = "imdb_num_votes", 
        "Critic's Score" = "critics_score", 
        "Audience's Score" = "audience_score", 
        "Movie Run Time" = "runtime"),
      selected = "audience_score"
    ),
    # Select variable for x-axis
    selectInput(
      inputId = "x",
      label = "X-axis:",
      choices = c(
        "IMBD Rating" = "imdb_rating",
        "Number of Votes on IMDB" = "imdb_num_votes", 
        "Critic's Score" = "critics_score", 
        "Audience's Score" = "audience_score", 
        "Movie Run Time" = "runtime"),
      selected = "critics_score"
    ),
    # Select point color
    selectInput(
      inputId = "z",
      label = "Data Point Color:",
      choices = c(
        "Category" = "title_type", 
        "Film Genre" = "genre", 
        "MPAA Rating" = "mpaa_rating", 
        "Critic's Rating" = "critics_rating", 
        "Audience Rating" = "audience_rating"),
      selected = "mpaa_rating"
    )
  ),
  # Output: Show scatterplot
  card(plotOutput(outputId = "scatterplot"))
)

# Define server

server <- function(input, output, session) {
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y, color = input$z)) +
      geom_point()
  })
}

# Create a Shiny app object

shinyApp(ui = ui, server = server)
