module.exports = ($scope, RESTHelperService, formatDateService) ->
  @$inject = ["$scope", "RESTHelperService"]

  controller = @

  controller.init = ->
    RESTHelperService.order.find (res) ->

      dates = (order) ->
        order.orderDate = formatDateService order.orderDate
        order.sendingDate = formatDateService order.sendingDate
        order

      controller.listOfOrders = (dates order for order in res.orders)

      $scope.$digest()

  controller.panel = "notAdminPanelView"

  controller.labels =
    _id: 40
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  controller.choose = (order) ->
    RESTHelperService.order.view files: order.files, (res) ->
      set = (wich) -> text: order[wich + "Text"], view: res[wich]
      $scope.order = order
      $scope.order.top = set "top"
      $scope.order.bottom = set "bottom"
      $scope.$digest()

  controller.init()

  controller
