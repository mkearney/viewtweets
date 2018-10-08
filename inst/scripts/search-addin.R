local({
  txt_input = function(..., width = '100%') shiny::textInput(..., width = width)
  shiny::runGadget(
    miniUI::miniPage(miniUI::miniContentPanel(
      shiny::fillRow(
        txt_input('query', 'Query', "", width = '98%'),
        height = '70px'
      ),
      miniUI::gadgetTitleBar(NULL)
    )),
    server = function(input, output, session) {
      shiny::observeEvent(input$done, {

        viewtweets:::view_search(input$query)
        shiny::stopApp()
      })
      shiny::observeEvent(input$cancel, {
        shiny::stopApp()
      })
    },
    stopOnCancel = TRUE,
    viewer = shiny::dialogViewer('Search Twitter',
      height = 50)
  )
})
