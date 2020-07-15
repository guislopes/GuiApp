#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    set.seed(123) #This is a fictional data set based on mtcars (re-purposed)
    a <- mtcars$mpg*runif(nrow(mtcars)*50, min = min(mtcars$mpg), max = max(mtcars$mpg))
    b <- a*rnorm(length(a), mean(a), 100)/100
    a <- a/100
    #plot(a,b)

    dt <- data.frame(a,b)

    model1 <- lm(b ~ a, dt)

    predict1 <- reactive({predict(model1, newdata = data.frame(a = input$sliderX/1000000))})
    output$sliderX <- reactive({input$sliderX})
    output$pred1 <- renderText({paste0("Congratulations, ", input$box1, "! Your channel with ", format(input$sliderX, big.mark=",", scientific = F), " followers is estimated to bring you a revenue from Ads of approximately $", format(round(predict(model1, newdata = data.frame(a = input$sliderX/1000000)),0), big.mark=","), " every month.")})
    output$pred2 <- renderText(paste0("Your level of influence is... ", ifelse(input$sliderX < 1000000, "Unnoticeable. From all your followers, pehaps a few hundreds really see your content at all.",
                                                                        ifelse(input$sliderX < 2000000, "Almost unnoticeable. Very few people change their opinions based on your statements.",
                                                                        ifelse(input$sliderX < 3000000, "Noticeable. Most of your followers are primed to trust you because of the size of your channel.",
                                                                        ifelse(input$sliderX < 4000000, "Very noticeable. Your statements can change most of your followers' opinions, but you are limited to those who follow you.",
                                                                        ifelse(input$sliderX < 5000000, "Influencial at a niche level. People interested in your niche will know you and may share your statements in their own channels.",
                                                                        ifelse(input$sliderX < 6000000, "Influencial beyond your niche. People outside your niche may hear about you. At this point, you have developed a solid fan base.",
                                                                        ifelse(input$sliderX < 7000000, "Very influencial. Local news may mention your statements if they are controversial enough. At this point, you have developed a base of haters.",
                                                                        ifelse(input$sliderX < 8000000, "Highly influential. Other influencers and local media often comment on your statements. Your statements can become memes at any moment now.",
                                                                        ifelse(input$sliderX < 10000000, "Massive. Your statements are often covered my national media, and can easily guide public opinion.",
                                                                        'Nation wide. Your statements are heavily shared by media and celebrities. No one can avoid being exposed to your statements.')))))))))))
    output$plot1 <- renderPlot({
        plot(
            x = a,
            y = b,
            col= "dark gray",
            xlab = "Number of followers (millions)",
            ylab = "Revenue from Ads (monthly; USD)",
            main = "Revenue from Ads x Number of followers (based on existent influencers)",
            xlim = c(0, 12),
            ylim = c(0, max(b)*1.05),
            )
        abline(model1, col = "red", lwd = 2, lty = 3)
        points(input$sliderX/1000000, predict1(), col = "black", pch = 16, cex = 2)
        text(x = 2,
             y = 6000,
             labels = paste0("Revenue = $", format(round(predict(model1, newdata = data.frame(a = input$sliderX/1000000)),0), big.mark=","), " (monthly)"),
             col = "black")
     })
})
