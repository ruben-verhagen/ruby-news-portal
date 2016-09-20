window.AdminApp.controller 'EmailAlertsScheduleFormController', ($scope, EmailAlertsSchedule) ->
  $scope.schedules = []
  $scope.emptySchedule =
    day_of_week: 0
    send_at: '12:00 AM'

  EmailAlertsSchedule.index().then (response) ->
    $scope.schedules = response.data
  $scope.addNew = () ->
    $scope.schedules.push({day_of_week: 0, send_at: '12:00 AM'})

  $scope.daysOfWeek = [
    { val: 0, name: 'Sunday' }
    { val: 1, name: 'Monday' }
    { val: 2, name: 'Tuesday' }
    { val: 3, name: 'Wednesday' }
    { val: 4, name: 'Thursday' }
    { val: 5, name: 'Friday' }
    { val: 6, name: 'Saturday' }
  ]

  $scope.submit = () ->
    EmailAlertsSchedule.save({schedules: $scope.schedules}).then (data) ->
      console.log 'cool'