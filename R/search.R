#' Render Twitter search results
#'
#' Render tweets matched to Twitter search
#'
#' @param query Search query used to find tweets.
#' @return Matching tweets will be displayed as temporary HTML file.
#' @export
view_search <- function(query) {
  if (is.null(query)) {
    query <- "filter:verified OR -filter:verified"
  }
  title <- "Search Results"
  tw <- rtweet::search_tweets(query, include_rts = FALSE)
  html_tweets(tw, title)
}


view_search_addin <- function() {
  sys.source(pkg_file('scripts', 'search-addin.R'))
}
