directive = ->

  templateUrl: "ordersBaseView"
  restrict: "E"
  scope: {}
  controller: "@"
  name: "ordersController"
  controllerAs: "ordersCtrl"

directive.$inject = []

module.exports = directive
