en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider, ChartJsProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider", "ChartJsProvider"]

  translateProvider.add en, bg

  $stateProvider
    .state "home.admin",
      url: "/admin"
      template: templateProvider.provide "adminView"

  ChartJsProvider.setOptions
    responsive: no
    colours: ["#FF0000", "#0000FF"]
