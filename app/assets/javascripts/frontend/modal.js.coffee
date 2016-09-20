class window.Modal
  HIDE_TIME = 300

  constructor: (modalEl, config = {}) ->
    @modalEl = $(modalEl)
    @fadeEl = $('[data-fade-overlay]')
    @onClose = config.onClose
    @onOpen = config.onOpen

    @bindCloseButton()

  bindCloseButton: ->
    @modalEl.find('[data-close-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @close()

  open: ->
    if @onOpen
      @onOpen()
    @fadeEl.stop().fadeIn(HIDE_TIME)
    @modalEl.stop().fadeIn(HIDE_TIME)

  close: ->
    if @onClose
      @onClose()
    @fadeEl.stop().fadeOut(HIDE_TIME)
    @modalEl.stop().fadeOut(HIDE_TIME)