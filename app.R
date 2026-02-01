
library(shiny)
source("R/openai_client.R")

ui <- fluidPage(
  textAreaInput("question", "Ask GPT"),
  actionButton("ask", "Submit"),
  verbatimTextOutput("answer")
)

server <- function(input, output) {

  observeEvent(input$ask, {

    output$answer <- renderText({
      call_chatgpt(input$question)
    })

  })

}

shinyApp(ui, server)
