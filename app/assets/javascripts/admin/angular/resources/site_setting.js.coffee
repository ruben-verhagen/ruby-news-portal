window.AdminApp.factory 'SiteSetting', (railsResourceFactory) ->
  railsResourceFactory
    url: "/admin/settings"
    name: "site_setting"