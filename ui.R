
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("SIRD Model of Epidemic Dynamics"),
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    helpText("S=Susceptible to Infection; I=Infected; R=Recovered/Resistant to Infection; D=Dead"),
    numericInput("S", "# Susceptible Hosts:", min = 100, max = 10000, value = 1000),
    numericInput("I", "# Infected Hosts:", min = 1, max = 10000, value = 15),
    sliderInput("nreps", "Number of Time Steps:", min = 10, max = 150, value = 100),
    numericInput("beta", "Beta Constant:", min = 0, max = 1, value = .0005, step=.0001),
    numericInput("gamma", "Gamma Constant:", min = 0, max = 1, value = .05, step=.01),
    numericInput("mu", "Mu Constant:", min = 0, max = 1, value = .02, step=.01)
  ),
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot", height="550px")
  )
))
