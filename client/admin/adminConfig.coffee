en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, templateProvider, translateProvider, ChartJsProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home.admin",
      url: "/admin"
      template: templateProvider.provide "adminView"

  ChartJsProvider.setOptions
    responsive: no
    colours: ["#FF0000", "#0000FF"]

config.$inject = ["$stateProvider", "templateProvider", "translateProvider", "ChartJsProvider"]

module.exports = config
