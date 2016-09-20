window.SocialSharer =
  openPopup: (url, width=600, height=450) ->
    winTop = (screen.height / 2) - (width / 2)
    winLeft = (screen.width / 2) - (height / 2)
    popup = window.open(url, 'sharer', 'top=' + winTop + ',left=' + winLeft + ',toolbar=0,status=0,width=' + width + ',height=' + height)

    true

  shareToFb: (purl, title='', text='', image_url='') ->
    url  = 'http://www.facebook.com/sharer.php?s=100'
    url += '&p[url]='       + encodeURIComponent(purl)
    url += '&p[title]='     + encodeURIComponent(title)
    url += '&p[summary]='   + encodeURIComponent(text)
    url += '&p[images][0]=' + encodeURIComponent(image_url)

    @openPopup(url)

  shareToTw: (purl, title='') ->
    #title = [title, purl].join(' ')
    url  = 'https://twitter.com/intent/tweet?'
    url += 'text='      + encodeURIComponent(title)
    url += '&url='      + encodeURIComponent(purl)

    @openPopup(url)

  shareToGp: (purl, title='') ->
    url  = 'https://plus.google.com/share?'
    url += '&url='      + encodeURIComponent(purl)
    url += 'title='     + encodeURIComponent(title)

    @openPopup(url)

  shareToLi: (purl, title='') ->
    url  = 'http://www.linkedin.com/shareArticle?mini=true?'
    url += '&url='      + encodeURIComponent(purl)
    url += 'title='     + encodeURIComponent(title)

    @openPopup(url)

  shareToXing: (purl, title='') ->
    url  = 'https://www.xing.com/social_plugins/share?'
    url += '&url='      + encodeURIComponent(purl)

    @openPopup(url)