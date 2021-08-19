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
            h3("Build your own Dr Lee:"),
            
            # Age
            sliderInput("age",
                        label = "How old is Philip?",
                        min = 0, max = 100, value = 40),
            
            # Paper size
            selectInput("size", 
                        label = "What size is Mehul's certificate?",
                        choices = list("Business Card", 
                                       "A7",
                                       "A6", 
                                       "A5",
                                       "A4",
                                       "A3", 
                                       "A2",
                                       "A1",
                                       "A0"),
                        selected = "A4"),
            
            # Height
            strong("Select Philip's head-to-knee height on the image:"),
            textOutput("height_in_px"),
            
            
            h3("Results:"),
            textOutput("selected_var"),
            
            # Footer
            p("A stupid product of ",
              a("@Nickopotamus", href = "http://twitter.com/nickopotamus"),
              " and ",
              a("@loki1706", href = "http://twitter.com/@loki1706"))
        ),
        
        # Philip picture
        mainPanel(
            plotOutput(
                outputId = "plot1",
                width = "100%",
                height = "500px",
                brush = "plot_brush"),
            verbatimTextOutput("info")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # Sidebar outputs
    output$selected_var <- renderText({ 
        paste("You have selected:", input$age)
    })
    
    ## Main outputs
    # Plot Philip
    output$plot1 <- renderImage({
        list(src = "www/philip.jpeg")
    }, deleteFile = FALSE)
    
    # Return coords
    output$height_in_px <- renderText({
        y_range <- function(e) {
            if(is.null(e)) return(0)
            round(e$ymax - e$ymin, 1)
        }
        
        paste0("Height: ", y_range(input$plot_brush), " px")
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
