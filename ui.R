
library(shiny)
library(plotly)
library(ggplot2)

# Define UI for application
shinyUI(fluidPage(
      
      titlePanel("EDA helper"),
      h4(em("**Start by uploading a dataset (only csv allowed). Tidy datasets are strongly suggested.")),
      h4(em("Try available datasets, like `iris` or `mtcars`, but you can supply your own.")),
      h4(em("Then choose 3 variables from drop-down lists (generated from column names): numeric or categorical (factor).")),
      h4(em("First variable of provided dataset is selected by default. You can choose different ones
            anytime.")),
      h4(em("This app provides means to explore 3 individual variables, as well as association between variables X and Y.")),
      h4(em("Variable A is used as an auxilary variable in `joint visualisation section`.**")),
      
      fluidRow(
            column(4,
                   
            fileInput(inputId="dataset", label="Dataset to explore",
                  accept = c("text/csv",
                        "text/comma-separated-values,text/plain",".csv") )),
            
            column(4,
            selectInput(inputId="var1", label="Select variable X",
                        choices = "var_x"),
                   
            selectInput(inputId="var2", label="Select variable Y",
                        choices = "var_y"),
            
            selectInput(inputId="var3", label="Select accessory variable A",
                        choices = "var_a")
            )
      ),
      hr(),
      
      fluidRow(
        h4(em("**Essential info on selected variables is presented in this section**")),
            column(4,
                   h4("Variable X"),
                   verbatimTextOutput("varX_type"),
                   verbatimTextOutput("varX_cont"),
                   verbatimTextOutput("varX_na")
            ),
            column(4,
                   h4("Variable Y"),
                   verbatimTextOutput("varY_type"),
                   verbatimTextOutput("varY_cont"),
                   verbatimTextOutput("varY_na")
            ),
            column(4,
                   
                   h4("Variable A"),
                   verbatimTextOutput("varA_type"),
                   verbatimTextOutput("varA_cont"),
                   verbatimTextOutput("varA_na")
            ) ),
      
      hr(),
      fluidRow(
        h4(em("**This section presents distibutions of selected variables.")),
        h4(em("Plots are generated automatically, based on your choice of X, Y and A variables.**")),
            column(4,
                  h4("Variable X plot"),
                  plotOutput("distX_plot")
            ),
            column(4,
                   h4("Variable Y plot"),
                   plotOutput("distY_plot")
            ),
            column(4,
                   h4("Variable A plot"),
                   plotOutput("distA_plot")
            ) ),
      
      hr(),
      fluidRow(
            column(10, offset = 1,
                   h4("Joint visualisation of selected variables"),
                   plotOutput("joint_plot")
            )),
      
      hr(),
      
      fluidRow(
        column(5,
               h4("Correlation coefficient for variables X and Y:")
               ),
        column(7,
               verbatimTextOutput("corrXY")
        )),
      
      h3("Summary statistics"),
      
      fluidRow(
            column(5,
                   
                   h4("Summary of variable X"),
                   verbatimTextOutput("varX_info"),
                   
                   h4("Summary of variable Y"),
                   verbatimTextOutput("varY_info"),
                   
                   h4("Summary of variable A"),
                   verbatimTextOutput("varA_info")
            ),
            column(7,
                   
                   h4("Dataset structure"),
                   verbatimTextOutput("str"),
                   verbatimTextOutput("var_x"),
                   verbatimTextOutput("var_y"),
                   verbatimTextOutput("var_a")
            ) )
      ))
