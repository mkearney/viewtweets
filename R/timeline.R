

#' Render timeline tweets
#'
#' Render tweets posted to home (authenticating) user's timeline
#'
#' @param user Name of user; used to determine timeline. If NULL (default), this
#'   returns the home timeline of the authenticating user. If a user name is
#'   provided, the timeline will display tweets sent by that user.
#' @return Timeline will be displayed as temporary HTML file.
#' @export
view_timeline <- function(user = NULL) {
  if (is.null(user)) {
    tw <- rtweet::get_my_timeline()
    user <- rtweet:::home_user()
    title <- paste0("@", user, "'s timeline")
  } else {
    tw <- rtweet::get_timeline(user)
    tw <- tw[!tw$is_retweet, ]
    title <- paste0("@", user, "'s tweets")
  }
  html_tweets(tw, title)
}


pkg_file <- function (..., mustWork = TRUE) {
  system.file(..., package = "viewtweets", mustWork = mustWork)
}

view_user_addin <- function() {
  sys.source(pkg_file('scripts', 'user-addin.R'))
}

view_home_addin <- function() {
  sys.source(pkg_file('scripts', 'home-addin.R'))
}

