class window.CollapsableArticle
  constructor: (@articleEl) ->
    @id= @articleEl.data('post-id')
    @path = @articleEl.data('path')
    @contentArea = $(@articleEl.find('[data-text]'))
    @readMoreButton = $(@articleEl.find('[data-read-more]'))
    @popupButton = $(@articleEl.find('[data-open-premium-post-modal]'))

    @readMoreButton.show()

    @initializeContent()
    @bindExpand()

  initializeContent: ->
    @contentArea.css({ height: '194px' })


  bindExpand: ->
    @popupButton.on 'click touchstart', (e) ->
      e.preventDefault()
      if window.CookieReader.shouldSeeFullModal()

        freeTrialModal = new Modal("[data-premium-post-modal]")
        freeTrialModal.open()

      if window.CookieReader.shouldSeeLoginForm()
        loginModal = new Modal("[data-login-modal]")
        loginModal.open()

    @readMoreButton.on 'click', (e) =>
      e.preventDefault()
      @contentArea.css({ height: 'auto' })
      @readMoreButton.hide()

      if @path
        window.history.pushState('', '', @path)

      @markRead()

  markRead: ->
    $.post("/posts/#{@id}/mark-read")