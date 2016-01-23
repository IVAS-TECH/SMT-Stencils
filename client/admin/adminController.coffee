module.exports = ($controller, $scope, RESTHelperService, dateService, showDescriptionService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService", "dateService", "showDescriptionService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "dateService": dateService
    "showDescriptionService": showDescriptionService

  controller = $controller "ordersInterface", injectable

  controller.panel = "adminPanelView"

  stop = $scope.$watch "ordersCtrl.listOfOrders", (orders) ->

    beggin = controller.fromDate

    end = controller.toDate

    if end < beggin then [beggin, end] = [end, beggin]

    [controller.fromDate, controller.toDate] = [beggin, end]

    it = dateService.iterator beggin, end

    gap = end.getMonth() - beggin.getMonth()

    years = end.getFullYear() - beggin.getFullYear() + 1

    normalizate =  Math.abs (Math.floor end.getDate() / 3) - (Math.floor beggin.getDate() / 3)

    diff = Math.abs (Math.floor ((3 * gap * years) + 3 - normalizate) / 3) + 3

    console.log diff, normalizate

    interval =
      current: diff
      label: ""

    intervals = {}

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

    buildIntervals = (date) ->
      label = dateService.format date
      data = statisticData label
      if interval.current is diff
        interval.current = 0
        interval.label = label
        intervals[label] =
          count: 0
          delivered: 0
          revenue: 0
      else
        label = interval.label
        interval.current++
      for info in ["count", "delivered", "revenue"]
        intervals[label][info] += data[info]

    buildIntervals it.value while it.inc()

    buildCharts = ->

      labels = []

      charts =
        count:
          series: ["line-orders-count", "line-delivered"]
          data: [[], []]
        revenue:
          series: ["line-revenue"]
          data: [[]]

      for label, data of intervals
        labels.push label
        charts.count.data[0].push data.count
        charts.count.data[1].push data.delivered
        charts.revenue.data[0].push data.revenue

      charts.count.labels = labels
      charts.revenue.labels = labels

      charts

    controller.charts = buildCharts()

  $scope.$on "$destroy", stop

  controller.addDiscription = (order) -> controller.order = order

  controller.update = ->
    description =
      order: controller.order._id
      text: controller.description
    RESTHelperService.description.add description: description, (res) ->
      console.log "desc"

  controller.delete = ->
    console.log controller.discription

  controller
