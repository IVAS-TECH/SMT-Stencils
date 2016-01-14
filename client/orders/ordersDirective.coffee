module.exports = (template) ->
  @$inject = ["template"]

  template: template "ordersBaseView"
  restrict: "E"
  scope: yes
  controller: "@"
  name: "ordersController"
  controllerAs: "ordersCtrl"
