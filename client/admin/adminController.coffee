module.exports = ($controller, $scope, RESTHelperService, dateService, showStatisticsService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService", "dateService", "showStatisticsService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService

  controller = $controller "ordersInterface", injectable

  controller.panel = "adminPanelView"

  $scope.$watch "ordersCtrl.listOfOrders", (orders) ->
    it = dateService.iterator controller.fromDate, controller.toDate

    statisticData = (search) ->
      count = 0
      delivered = 0
      revenue = 0
      for order in orders
        if order.orderDate is search
          count++
          revenue += order.price
          if order.status is "delivered"
            delivered++
      count: count
      delivered: delivered
      revenue: revenue

    chart =
      series: [
        "line-orders-count"
        "line-delivered"
        "line-revenue"
      ]
      data: [[], [], []]
      labels:[]

    addToChart = (label) ->
      data = statisticData label
      chart.labels.push label
      chart.data[0].push data.count
      chart.data[1].push data.delivered
      chart.data[2].push data.revenue

    addToChart dateService.format it.value while it.inc()

    controller.chart = chart

  controller.addDiscription = (order) ->
    controller.choose order
    controller.order = order

  controller.update = ->
    console.log controller.discription

  controller.delete = ->
    console.log controller.discription

  controller
