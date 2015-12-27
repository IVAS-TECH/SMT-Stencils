module.exports = ($scope, RESTHelperService) ->
  controller = @
  controller.$inject = ["$scope", "RESTHelperService"]

  controller.init = ->
    RESTHelperService.order.find (res) ->
      if res.success
        controller.listOfOrders = res.orders
        $scope.$digest()

  controller.labels =
    id: 40
    status: 20
    price: 20
    date: 20

  controller.choose = (order) ->
    RESTHelperService.order.view files: order.files, (res) ->
      set = (wich) -> text: order[wich + "Text"], view: res[wich]
      $scope.order = order
      $scope.order.top = set "top"
      $scope.order.bottom = set "bottom"
      $scope.order.disabled = true
      $scope.$digest()

  controller.init()

  controller
