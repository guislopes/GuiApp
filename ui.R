#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Social Media: Revenue and Influence"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            textInput("box1", "Your Name:", value = "John"),
            sliderInput("sliderX", "Number of followers (millions)", min = 100000, max = 12000000, value = 1000000, step = 100, ticks = F, round = TRUE),
            h4("Purpose:"),
            h6('This Shiny App is meant for people interested in becoming social media influencers. It estimates the revenue from Ads and level of influence based on expected number of followers.'),
            h4("Instructions:"),
            h6('(1) Type your name in "Your Name:" box.'),
            h6('(2) Indicate how many followers your channel has on the slider.'),
            h6('(3) Check the results in the tabs.')),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Estimator", br(), plotOutput("plot1")),
                        tabPanel("Revenue", br(), textOutput("pred1")),
                        tabPanel("Influence", br(), textOutput("pred2"))),

        )
    )
))
