module.exports = ($controller, $scope, RESTHelperService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService

  controller = $controller "ordersInterface", injectable

  controller.panel = "adminPanelView"

  controller.status = ["new", "accepted", "send", "delivered", "rejected"]

  controller.addDiscription = (order) ->
    controller.choose order
    controller.order = order

  controller.update = ->
    console.log controller.discription

  controller.delete = ->
    console.log controller.discription

  controller
