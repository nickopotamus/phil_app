#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Paper size list from https://www.instantprint.co.uk/printspiration/print-design-tips/size-guide
paper <- tibble::tribble(
    ~paper, ~ height, 
    "Business Card", 5.5,
    "A7", 7.4,
    "A6", 10.5,
    "A5", 14.8,
    "A4", 21.0,
    "A3", 29.7,
    "A2", 42.0,
    "A1", 59.4,
    "A0", 84.1
)

# Certificate height in px
cert_height_px = 75

# Define UI for application 
ui <- fluidPage(

    # Application title
    titlePanel("How tall is Philip Lee?"),

    # Sidebar  
    sidebarLayout(
        position = "left",
        sidebarPanel(
            h4("Build your own Dr Lee:"),
            
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
            
            
            h4("Results:"),
            textOutput("cert_height"),
            textOutput("phil_height"),
            
            # Footer
            h4("Blame:"),
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
    
    # Calculations using reactive functions
    paper_height_cm <- reactive({
        paper$height[paper == input$size]
        })
    
    phil_height_px <- reactive({
        y_range <- function(e) {
            if(is.null(e)) return(0)
            e$ymax - e$ymin
        }
        return(y_range(input$plot_brush))
    })
    
    phil_height_cm <- reactive({
        rel_heights <- phil_height_px()/cert_height_px
        phil_head_knee_cm <- rel_heights * paper_height_cm()
        phil_knee_cm <- (phil_head_knee_cm - (84.88 - 0.24*input$age))/0.83
        return(phil_knee_cm + phil_head_knee_cm)
    })
    
    
    ## Sidebar outputs
    # Certificate height
    output$cert_height <- renderText({ 
        paste0("Mehul's certificate is ", paper_height_cm(), " cm high")
    })
    
    # Phil height
    output$phil_height <- renderText({ 
        paste0("Making Philip Lee ", round(phil_height_cm(),1), " cm tall")
    })
    
    ## Main outputs
    # Plot Philip
    output$plot1 <- renderImage({
        list(src = "www/philip.jpeg")
    }, deleteFile = FALSE)
    
    # Return coords
    output$height_in_px <- renderText({
        paste0(round(phil_height_px(),1), " px")
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
