module.exports = ($scope, RESTHelperService, $mdDateLocale) ->
  @$inject = ["$scope", "RESTHelperService", "$mdDateLocale"]

  controller = @

  controller.fromDate = new Date()

  controller.toDate = new Date()

  controller.status = ["new", "accepted", "send", "delivered", "rejected"]

  controller.init = ->
    RESTHelperService.order.find (res) ->

      dates = (order) ->
        for type in ["order", "sending"]
          date = type + "Date"
          order[date] = $mdDateLocale.formatDate order[date]
        order

      orders = res.orders
      controller.fromDate = new Date orders[orders.length - 1].orderDate
      controller.toDate = new Date orders[0].orderDate
      controller.listOfOrders = (dates order for order in orders).sort (a, b) ->
        indexA = controller.status.indexOf a.status
        indexB = controller.status.indexOf b.status
        indexA - indexB

      $scope.$digest()

  controller.panel = "notAdminPanelView"

  controller.labels =
    _id: 40
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  controller.compareableDate = (wich) ->
    controller[wich + "Date"] = $mdDateLocale.parseDate $mdDateLocale.formatDate controller[wich + "Date"]

  controller.datesFilter = (order) ->
    date = $mdDateLocale.parseDate order.orderDate
    controller.toDate >= date >= controller.fromDate

  controller.choose = (order) ->
    RESTHelperService.order.view files: order.files, (res) ->
      set = (wich) -> text: order[wich + "Text"], view: res[wich]
      $scope.order = order
      $scope.order.top = set "top"
      $scope.order.bottom = set "bottom"
      $scope.$digest()

  controller.init()

  controller
