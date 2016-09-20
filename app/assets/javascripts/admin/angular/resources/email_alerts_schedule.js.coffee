window.AdminApp.factory 'EmailAlertsSchedule', ($http) ->
  {
    index: () ->
      $http.get('/admin/settings/schedule.json')

    save: (data) ->
      $http.post('/admin/settings/schedule', site_setting: data)

  }