#' Render favorited tweets
#'
#' Render tweets favorited by a given user
#'
#' @param user Name of user; used to determine favorites. If NULL (default),
#'   this returns the favorites of the authenticating user. If a user name is
#'   provided, the displayed tweets will have been favorited by that user.
#' @return Favorited tweets will be displayed as temporary HTML file.
#' @export
view_favorites <- function(user = NULL) {
  if (is.null(user) | identical(user, "")) {
    user <- rtweet:::home_user()
  }
  tw <- rtweet::get_favorites(user, n = 200)
  tw <- tw[order(tw$created_at, decreasing = TRUE), ]
  title <- paste0("@", user, "'s favorites")
  html_tweets(tw, title)
}

view_favs_addin <- function() {
  sys.source(pkg_file('scripts', 'favs-addin.R'))
}
