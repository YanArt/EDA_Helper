shinyServer(function(input, output, session) {
      
      ## load dataset
      fileData <- reactive({
            inFile <- input$dataset
            if (is.null(inFile)) {return(NULL)}
            data.frame(read.csv(inFile$datapath))
      })
      
      varNames <- reactive({ names(fileData()) })
      
      ## variable names to choose from
      output$var_x <- reactive({ updateSelectInput( session = session,
                              "var1", choices = varNames()) })
      output$var_y <- reactive({ updateSelectInput( session = session,
                              "var2", choices = varNames()) })
      output$var_a <- reactive({ updateSelectInput( session = session,
                              "var3", choices = varNames()) })
      
      varX <- reactive({ fileData()[,c(input$var1)]})
      varY <- reactive({ fileData()[,c(input$var2)]})
      varA <- reactive({ fileData()[,c(input$var3)]})
      
      ## create printable structure report
      output$str <- renderPrint({ str(fileData()) })
      
      # selected variables type
      output$varX_type <- renderText({ 
            paste("type:", class(varX()), collapse = "" ) })
      output$varY_type <- renderText({ 
            c("type:", class(varY())) })
      output$varA_type <- renderText({ 
            c("type:", class(varA())) })
      
      # selected variables contents
      output$varX_cont <- renderText({
            if (is.numeric(varX())) {
                  c("range:", range(varX(), na.rm = TRUE))} else
            if (is.factor(varX())) {
                  c("unique:", unique(varX()))} })
      output$varY_cont <- renderText({
            if (is.numeric(varY())) {
                  c("range:", range(varY(), na.rm = TRUE))} else
            if (is.factor(varY())) {
                  c("unique:", unique(varY()))} })
      output$varA_cont <- renderText({
            if (is.numeric(varA())) {
                  c("range:", range(varA(), na.rm = TRUE))} else
            if (is.factor(varA())) {
                  c("unique:", unique(varA()))} })
     
      # missing values
      output$varX_na <- renderText({ c("missing:", sum(is.na(varX()))) })
      output$varY_na <- renderText({ c("missing:", sum(is.na(varY()))) })
      output$varA_na <- renderText({ c("missing:", sum(is.na(varA()))) })
      
      # selected variables summary
      output$varX_info <- renderPrint({ summary(varX()) })
      output$varY_info <- renderPrint({ summary(varY()) })
      output$varA_info <- renderPrint({ summary(varA()) })
      
      # create individual plots for both selected variables
      output$distX_plot <- renderPlot({
            if (is.numeric(varX())) {plot(x=sort(varX()), type = "h", 
                  main = "Variable X (sorted)", ylab=c(input$var1))} else
            if (is.factor(varX())) {plot(varX(), space = 0.1, 
                  beside = TRUE, main = "Variable X", ylab=c(input$var1))}
      })
      
      output$distY_plot <- renderPlot({
            if (is.numeric(varY())) {plot(x=sort(varY()), type = "h", 
                  main = "Variable Y (sorted)", ylab=c(input$var2))} else
            if (is.factor(varY())) {plot(varY(), space = 0.1, 
                  beside = TRUE, main = "Variable Y", ylab=c(input$var2))}
      })
      
      output$distA_plot <- renderPlot({
            if (is.numeric(varA())) {plot(x=sort(varA()), type = "h", 
                  main = "Variable A (sorted)", ylab=c(input$var3))} else
            if (is.factor(varA())) {plot(varA(), space = 0.1, 
                  beside = TRUE, main = "Variable A", ylab=c(input$var3))}
      }) 
      
      # create joint plot for selected variables
      output$joint_plot <- renderPlot({
        labX <- c(input$var1)
        labY <- c(input$var2)
        qplot(x=varX(), y=varY(), colour=varA(), xlab=labX, ylab=labY)
      })
      
      # correlation between X and Y
      output$corrXY <- renderPrint({ cor(x=varX(), y=varY()) })
      
})