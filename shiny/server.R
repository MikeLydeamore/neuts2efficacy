library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(data.table)
library(scales)

. <- lapply(list.files("../R", full.names = TRUE), source)
source("../packages.R")
source("clean_pltly_legend.R")

function(input, output) {
    
    waning_predictions_omicron <- reactive({
        
        df <- read.csv("./shinydata/ve_waning_predictions_omicron.csv")
        if (!input$show_natural_infection) {
            df <- dplyr::filter(df, ! immunity %like% "omicron_infection")
        }
        if (!input$show_absence_infection) {
            df <- dplyr::filter(df, immunity %like% "omicron_infection")
        }

        df
    })

    omicron_ve_data <- reactive({
        df <- read.csv("./shinydata/omicron_ve_data.csv")
    })

    output$plot <- renderPlotly({
        # If no line options are selected, return NULL to avoid error
        if (nrow(waning_predictions_omicron()) == 0) {
            return (NULL)
        }

        if (input$show_data) {
            p <- plot_waning(
            waning_predictions_omicron(),
            omicron_ve_data(),
            immunity_levels = c(
                "Omicron Infection",
                "Pfizer vaccine dose 2 + Omicron infection",
                "mRNA booster + Omicron infection",
                "mRNA booster",
                "Pfizer vaccine dose 2",
                "AZ vaccine dose 2",
                "mRNA dose 4",
                "mRNA dose 4 + Omicron infection")
            ) +
            ggtitle("Predicted waning in vaccine efficacy against the Omicron variant")
        } else {
            p <- plot_waning(
                waning_predictions_omicron(),
                immunity_levels = c(
                    "Omicron Infection",
                    "Pfizer vaccine dose 2 + Omicron infection",
                    "mRNA booster + Omicron infection",
                    "mRNA booster",
                    "Pfizer vaccine dose 2",
                    "AZ vaccine dose 2",
                    "mRNA dose 4",
                    "mRNA dose 4 + Omicron infection")
                ) +
                ggtitle("Predicted waning in vaccine efficacy against the Omicron variant")
        }


        gp <- plotly_build(p)

        clean_pltly_legend(gp)

    })

}