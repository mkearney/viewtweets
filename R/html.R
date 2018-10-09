
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

  m <- tfse::gregexpr_(x$text, "#[[:alnum:]_]+")
  sns <- tfse::regmatches_(x$text, "#[[:alnum:]_]+")
  regmatches(x$text, m) <- lapply(
    sns, function(.x) ifelse(
      length(.x) > 0 | (!is.na(.x) & .x != ""),
      paste0('<a href="https://twitter.com/hashtag/',
        sub("#", "", .x), '?src=hashtag_click">', .x, '</a>'),
      ""))

  x$media <- sapply(x$media_url, function(.x) .x[1])
  x$media[!is.na(x$media)] <- sapply(x$media[!is.na(x$media)],
    function(.x) tfse::psub(
      '<img class="media" src="{media}" align="middle" width="100px"</>',
      media = .x)
  )
  x$media[is.na(x$media)] <- ""

  x$media2 <- sapply(x$ext_media_url, function(.x)
    ifelse(length(.x) > 1, .x[2], NA_character_))
  x$media2[!is.na(x$media2)] <- sapply(x$media2[!is.na(x$media2)],
    function(.x) tfse::psub(
      '<img class="media" src="{media}" align="middle" width="100px"</>',
      media = .x)
  )
  x$media2[is.na(x$media2)] <- ""

  x$media3 <- sapply(x$ext_media_url, function(.x)
    ifelse(length(.x) > 2, .x[3], NA_character_))
  x$media3[!is.na(x$media3)] <- sapply(x$media3[!is.na(x$media3)],
    function(.x) tfse::psub(
      '<img class="media" src="{media}" align="middle" width="100px"</>',
      media = .x)
  )
  x$media3[is.na(x$media3)] <- ""


  x$media4 <- sapply(x$ext_media_url, function(.x)
    ifelse(length(.x) > 3, .x[4], NA_character_))
  x$media4[!is.na(x$media4)] <- sapply(x$media4[!is.na(x$media4)],
    function(.x) tfse::psub(
      '<img class="media" src="{media}" align="middle" width="100px"</>',
      media = .x)
  )
  x$media4[is.na(x$media4)] <- ""


  x$media <- paste0('<div class="trim">',
    x$media, x$media2, x$media3, x$media4,
    '</div>')

  x <- glue::glue_data(x,
    paste0('<div><img class="profile" src="{profile_image_url}" style="float:left"</>',
      '<p class="name">{name}</p>\n',
      '<p class="screen_name">@{screen_name}:</p>\n',
      '<p class="text">{text}</p>\n',
      '<p class="time">{created_at}</p>\n',
      '<p class="media">{media}</p>\n',
      '</div><hr>'))
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
