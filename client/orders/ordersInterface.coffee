module.exports = ($scope, RESTHelperService, $filter, dateService, showDescriptionService, getStatusOptionsService) ->
  @$inject = ["$scope", "RESTHelperService", "$filter", "dateService", "showDescriptionService", "getStatusOptionsService"]

  controller = @

  controller.fromDate = new Date()

  controller.toDate = new Date()

  controller.status = getStatusOptionsService()

  controller.listOfOrders = []

  init = ->
    RESTHelperService.order.find (res) ->

      dates = (order) ->

        for type in ["order", "sending"]
          date = type + "Date"
          order[date] = dateService.format order[date]
        order

      orders = res.orders
      controller.fromDate = dateService.compatible orders[orders.length - 1].orderDate
      controller.toDate = dateService.compatible orders[0].orderDate
      controller.fullListOfOrders = (dates order for order in orders).sort (a, b) ->
        indexA = controller.status.indexOf a.status
        indexB = controller.status.indexOf b.status
        indexA - indexB
      controller.listOfOrders = controller.fullListOfOrders

      filter = $filter "filter"

      filterFn = (newValue) ->
        filtered = filter controller.fullListOfOrders, controller.filter
        controller.listOfOrders = filter filtered, (order) ->
          date = dateService.parse order.orderDate
          controller.toDate >= date >= controller.fromDate
        if controller.showing?
          controller.listOfOrders = filter controller.listOfOrders, _id: controller.showing

      listeners = ($scope.$watch "ordersCtrl." + watch, filterFn for watch in ["filter", "fromDate", "toDate", "showing"])

      $scope.$on "$destroy", -> listener() for listener in listeners

      $scope.$digest()

  controller.labels =
    _id: 25
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  controller.compareableDate = (wich) ->
    controller[wich + "Date"] = dateService.compatible controller[wich + "Date"]

  controller.showAll = -> delete controller.showing

  controller.choose = (event, order) ->

    choose = ->
      RESTHelperService.order.view files: order.files, (res) ->
        set = (wich) -> text: order[wich + "Text"], view: res[wich]
        $scope.order = order
        $scope.order.top = set "top"
        $scope.order.bottom = set "bottom"
        $scope.$digest()

    controller.showing = order._id

    RESTHelperService.description.find order._id, (res) ->
      if res.description?
        showDescriptionService event, {info: res.description}, success: -> #choose()
      else choose()

  init()

  controller
