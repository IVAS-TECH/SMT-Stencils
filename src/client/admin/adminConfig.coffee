en = require "./language-en"
bg = require "./language-bg"

config = ($stateProvider, translateProvider, ChartJsProvider) ->

  translateProvider.add en, bg

  $stateProvider
    .state "home.admin", url: "/admin", templateUrl: "adminView"
    .state "home.admin.users", url: "/users", controller: "usersController as usersCtrl", templateUrl: "usersView"
    .state "home.admin.profile", url: "/profile", controller: "profileController as profileCtrl", templateUrl: "profileView"
    .state "home.admin.logs", url: "/logs", controller: "logsController as logsCtrl", templateUrl: "logsView"

  ChartJsProvider.setOptions responsive: no, colours: ["#FF0000", "#0000FF"]

config.$inject = ["$stateProvider", "translateProvider", "ChartJsProvider"]

module.exports = config
