#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("How tall is Philip Lee?"),

    # Sidebar  
    sidebarLayout(
        position = "left",
        sidebarPanel(
            h4("Build your own Dr Lee:"),
            p("Age slider"),
            p("Paper size dropdown"),
            h4("Results:"),
            p("Height")
        ),
        mainPanel(
            img(src = "philip.jpeg", height = 500),
            p("A stupid product of ",
              a("@Nickopotamus", href = "http://twitter.com/nickopotamus"),
              " and ",
              a("@loki1706", href = "http://twitter.com/@loki1706"))
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)
