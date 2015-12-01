en = require "./language-en"
bg = require "./language-bg"

module.exports = ($stateProvider, templateProvider, translateProvider) ->
  @$inject = ["$stateProvider", "templateProvider", "translateProvider"]
  translateProvider.add en, bg
  $stateProvider
    .state "home.order", url: "/order", template: "O"
    .state "home.order.config", template: "C"#, controller: "profileController as profileCtrl", template: templateProvider.provide "profileView"
    #.state "home.order.order"###
