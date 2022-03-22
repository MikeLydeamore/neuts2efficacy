library(shiny)
library(ggplot2)

. <- lapply(list.files("../R", full.names = TRUE), source)
source("../packages.R")

fluidPage(
    titlePanel("COVID-19 Vaccine Efficacy Predictions"),

    sidebarPanel(
        h5("Line filters"),
        # Filter to include natural infection lines
        checkboxInput('show_natural_infection', "Curves include prior exposure", value=TRUE),
        # Filter to include no prior exposure lines
        checkboxInput('show_absence_infection', "Curves include no prior exposure", value=TRUE),

        h5("Data"),
        checkboxInput('show_data', "Show data", value=FALSE),
    width = 3),

    mainPanel(
        plotlyOutput('plot')
    )
)