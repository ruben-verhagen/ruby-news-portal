window.AdminApp.controller 'SiteSettingsController', ($scope, SiteSetting) ->
  SiteSetting.query().then (siteSettings) ->
    $scope.siteSettings = siteSettings