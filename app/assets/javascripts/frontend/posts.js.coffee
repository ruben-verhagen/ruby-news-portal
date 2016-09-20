$ ->
  window.loading_posts = false
  $('.load-more-posts-container').on 'inview', (e, visible) ->
    return if window.loading_posts or not visible
    window.loading_posts = true

    link = $(this).find('a').attr('href')

    $.getScript link, ->
      window.loading_posts = false