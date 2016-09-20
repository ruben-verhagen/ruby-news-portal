window.AdminApp.directive 'timePicker', () ->
  link: (scope, elem, attrs) ->
    elem.timepicker()