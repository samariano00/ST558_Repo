#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(bslib)
library(maps)
library(mapproj)

source("helpers.R")
counties <- readRDS("data/counties.rds")

# User interface ----
ui <- page_sidebar(
  title = "censusVis",
  
  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices =
        c(
          "Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"
        ),
      selected = "Percent White"
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0, 
      max = 100, 
      value = c(0, 100)
    )
  ),
  
  card(plotOutput("map"))
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    percent_map(counties$hispanic, "blue","% Hispanic")
  })
}

# Run app ----
shinyApp(ui, server)
