module.exports = ($scope, RESTHelperService) ->
  controller = @
  controller.$inject = ["$scope", "RESTHelperService"]

  controller.init = ->
    RESTHelperService.order.find (res) ->
      if res.success
        controller.listOfOrders = res.orders
        $scope.$digest()

  controller.choose = (order) ->
    console.log order
    controller.order = order
    controller.order.bottom = text: order.bottomText
    controller.order.top = text: order.topText
    controller.order.disabled = true

  controller.init()

  controller
