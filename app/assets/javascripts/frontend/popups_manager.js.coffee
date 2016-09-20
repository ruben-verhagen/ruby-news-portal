class window.PopupsManager
  constructor: () ->

  @closeAllModals: () ->
    $.each @modals, () ->
      @close()

  @createModals: () ->
    @premiumPostModal  = new Modal("[data-premium-post-modal]")

    @loginModal = new Modal("[data-login-modal]")
    @registerModal = new Modal("[data-register-modal]")
    @freeTrialModal = new Modal("[data-free-trial-modal]")

    @expiredTrialModal = new Modal("[data-expired-trial-modal]")

    @thanksTrialModal = new Modal("[data-thanks-trial-modal]")
    @thanksRegisterModal = new Modal("[data-thanks-register-modal]")
    @shortRegisterModal = new Modal("[data-short-register-modal]")

    @weekExpirationModal = new Modal("[data-week-expiration-modal]")
    @fewDaysExpirationModal = new Modal("[data-few-days-expiration-modal]")

    @modals = [
      @premiumPostModal,
      @loginModal, @registerModal, @shortRegisterModal, @freeTrialModal,
      @expiredTrialModal, @weekExpirationModal, @fewDaysExpirationModal,
      @thanksTrialModal, @thanksRegisterModal, @shortRegisterModal
    ]

  @initHandlers: () ->
    @initClickHandlers()
    @initTimeoutHandlers()

  @initClickHandlers: () ->
    $('[data-open-login-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @closeAllModals()
      @loginModal.open()
    $('[data-open-free-trial-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @closeAllModals()
      @freeTrialModal.open()
    $('[data-open-register-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @closeAllModals()
      @registerModal.open()
    $('[data-open-short-register-modal]').on 'click touchstart', (e) =>
      e.preventDefault()
      @closeAllModals()
      @shortRegisterModal.open()

  @initTimeoutHandlers: () ->
#    if window.CookieReader.getRole() == 'guest'
#      setTimeout () =>
#        @closeAllModals()
#        @premiumPostModal.open()
#      , 10000
    if window.CookieReader.shouldSeeExpiredTrialModal()
      setTimeout () =>
        @closeAllModals()
        @expiredTrialModal.open()
      , 10000

    else
      if window.CookieReader.shouldSeeFewDaysExpirationModal()
        setTimeout () =>
          @closeAllModals()
          @fewDaysExpirationModal.open()
          $.cookie('seen_few_days_expiration_popup', 'true', { expires: 30, path: '/' })
        , 10000
      else
        if window.CookieReader.shouldSeeWeekExpirationModal()
          setTimeout () =>
            @closeAllModals()
            @weekExpirationModal.open()
            $.cookie('seen_week_expiration_popup', 'true', { expires: 30, path: '/' })
          , 10000