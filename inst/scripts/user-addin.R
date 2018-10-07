local({
  txt_input = function(..., width = '100%') shiny::textInput(..., width = width)
  shiny::runGadget(
    miniUI::miniPage(miniUI::miniContentPanel(
      shiny::fillRow(
        txt_input('user', 'User', "", width = '98%'),
        height = '70px'
      ),
      miniUI::gadgetTitleBar(NULL)
    )),
    server = function(input, output, session) {
      shiny::observeEvent(input$done, {

        viewtweets:::view_timeline(input$user)
        shiny::stopApp()
      })
      shiny::observeEvent(input$cancel, {
        shiny::stopApp()
      })
    },
    stopOnCancel = TRUE,
    viewer = shiny::dialogViewer('Twitter Timeline',
      height = 50)
  )
})
