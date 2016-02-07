directive = ->

  templateUrl: "ordersBaseView"
  restrict: "E"
  scope: yes
  controller: "@"
  name: "ordersController"
  controllerAs: "ordersCtrl"

directive.$inject = []

module.exports = directive
