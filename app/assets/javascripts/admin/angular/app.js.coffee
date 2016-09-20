window.AdminApp = angular.module 'AdminApp', ['rails', 'ngResource', 'xeditable', 'ng-rails-csrf']
window.AdminApp.run (editableOptions, editableThemes) ->
  editableThemes.bs3.inputClass = 'input-sm'
  editableThemes.bs3.buttonsClass = 'btn-sm'
  editableOptions.theme = 'bs3'

