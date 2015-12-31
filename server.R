
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
require(reshape2)
require(ggplot2)

shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    #SIRD Model of Disease Transmission
    S=input$S
    I=input$I
    R=0
    D=0
    popsize = S+I+R+D
    nreps = input$nreps
    beta = input$beta
    gamma = input$gamma
    mu = input$mu
    #Create History Dataframe
    history = data.frame(time=0, S=S,I=I,R=R,D=D);
    #Loop over step function
    for(time in 1:nreps){
      newInf = pmin(S, floor(beta*I*S))
      newRec = pmin(I, floor(gamma*I))
      S = S - newInf
      I = I + newInf - newRec
      R = R + newRec
      newDead = pmin(I, floor(mu*I))
      I = I- newDead
      D = D + newDead
      history = rbind(history, data.frame(time, S, I, R, D))
    }
    #And finally plot
    plotdat = melt(history, id.vars = c("time"))
    ggplot(data=plotdat)+
      aes(x=time, y=value, color=variable)+
      geom_line(size=2)+
      theme_set(theme_gray(base_size = 15))+
      xlab("Time Step")+ylab("# Indv.")+
      ggtitle(paste("SIRD Epidemic Dynamics\nβ=",beta,"; γ=",gamma,"; μ=",mu,"\n", sep=""))+
      scale_color_manual(name="Disease State", values=c("blue", "orange", "green", "red"))
  })
  
})
