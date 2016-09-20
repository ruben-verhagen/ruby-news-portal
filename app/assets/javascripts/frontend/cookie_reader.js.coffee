class window.CookieReader
  constructor: () ->

  @getRole: () ->
    role = $.cookie('role')
    role || 'guest'

  @shouldSeeFullModal: () ->
    !gon.userLoggedIn && @in(@getRole(), ['email_registrant', 'trial_registrant', 'guest'])

  @shouldSeeLoginForm: () ->
    !gon.userLoggedIn && @in(@getRole(), ['trialist', 'subscriber'])

  @shouldSeeExpiredTrialModal: () ->
    !gon.userLoggedIn && @getRole() == 'email_registrant' && $.cookie('show_expired_trial') == 'true'

  @shouldSeeExpiredSubscriptionModal: () ->
    !gon.userLoggedIn && @getRole() == 'email_registrant' && $.cookie('show_expired_subscription') == 'true'

  @shouldSeeWeekExpirationModal: () ->
    gon.userLoggedIn && $.cookie('show_week_expiration_popup') == 'true' && !$.cookie('seen_week_expiration_popup')

  @shouldSeeFewDaysExpirationModal: () ->
    gon.userLoggedIn && $.cookie('show_few_days_expiration_popup') == 'true' && !$.cookie('seen_few_days_expiration_popup')

  @in: (value, array) ->
    array.indexOf(value) >= 0