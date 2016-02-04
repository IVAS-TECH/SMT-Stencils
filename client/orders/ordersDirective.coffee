directive = (template) ->

  template: template "ordersBaseView"
  restrict: "E"
  scope: yes
  controller: "@"
  name: "ordersController"
  controllerAs: "ordersCtrl"

directive.$inject = ["template"]

module.exports = directive
