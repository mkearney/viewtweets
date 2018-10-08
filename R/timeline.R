
#' Render tweets
#'
#' Render non-retweets as temporary HTML file
#'
#' @param x Timeline data returned by \link[rtweet]{get_my_timeline}.
#' @param title Optional, title of rendered tweets document.
#' @return Saves a temporary HTML file.
#' @export
html_tweets <- function(x, title = NULL) {
  x$text <- gsub("\\{", "VIEWTWEETS_OPEN_BRACKET", x$text)
  x$text <- gsub("\\}", "VIEWTWEETS_CLOSE_BRACKET", x$text)
  m <- tfse::gregexpr_(x$text, "https?://\\S+")
  links <- tfse::regmatches_(x$text, "https?://\\S+")
  regmatches(x$text, m) <- lapply(
    links, function(.x) ifelse(
    length(.x) > 0 | (!is.na(.x) & .x != ""),
    paste0('<a href="', .x, '">', .x, '</a>'),
    ""))
  m <- tfse::gregexpr_(x$text, "@[[:alnum:]_]+")
  sns <- tfse::regmatches_(x$text, "@[[:alnum:]_]+")
  regmatches(x$text, m) <- lapply(
    sns, function(.x) ifelse(
      length(.x) > 0 | (!is.na(.x) & .x != ""),
      paste0('<a href="https://twitter.com/',
        sub("@", "", .x), '">', .x, '</a>'),
      ""))

  x <- glue::glue_data(x,
    paste0('<div><img src="{profile_image_url}" style="float:left"</>',
  '<p class="name">{name}</p>\n',
  '<p class="screen_name">@{screen_name}:</p>\n',
  '<p class="text">{text}</p>\n',
  '<p class="time">{created_at}</p></div>\n<hr>'))
  x <- paste(x, collapse = "\n")
  if (!is.null(title)) {
    x <- glue::glue(
      "<h1 style='text-align:center'>{title}</h1>\n", x)
  }
  x <- sub("\\{body\\}", x, htmldoc)
  x <- gsub("VIEWTWEETS_OPEN_BRACKET", "{", x)
  x <- gsub("VIEWTWEETS_CLOSE_BRACKET", "}", x)

  tmp <- tempfile(fileext = ".html")
  writeLines(x, tmp)
  if (rstudioapi::isAvailable()) {
    rstudioapi::viewer(tmp)
  } else {
    browseURL(tmp)
  }
  invisible(tmp)
}

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
