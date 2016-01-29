module.exports = ($controller, $scope, RESTHelperService, $filter, dateService, showDescriptionService, getStatusOptionsService, notificationService, confirmService) ->
  @$inject = ["$controller", "$scope", "RESTHelperService", "$filter", "dateService", "showDescriptionService", "getStatusOptionsService", "notificationService", "confirmService"]

  injectable =
    "$scope": $scope
    "RESTHelperService": RESTHelperService
    "dateService": dateService
    "showDescriptionService": showDescriptionService

  controller = $controller "ordersInterface", injectable

  controller.adminPanel = "adminPanelView"

  init = ->

    RESTHelperService.visit.find (res) ->

      controller.listOfVisits = res.visits

      stop = $scope.$watch "ordersCtrl.listOfOrders", (orders) ->

        if not orders? then return

        beggin = controller.fromDate

        end = controller.toDate

        if end < beggin then [beggin, end] = [end, beggin]

        [controller.fromDate, controller.toDate] = [beggin, end]

        it = dateService.iterator beggin, end

        gap = end.getMonth() - beggin.getMonth()

        years = end.getFullYear() - beggin.getFullYear() + 1

        normalizate =  Math.abs (Math.floor end.getDate() / 3) - (Math.floor beggin.getDate() / 3)

        diff = Math.abs (Math.floor ((3 * gap * years) + 3 - normalizate) / 3) + 3

        interval =
          current: diff
          label: ""

        intervals = {}

        statisticData = (search) ->
          count = 0
          delivered = 0
          revenue = 0
          visits = 0
          users = 0
          for order in orders
            if order.orderDate is search
              count++
              revenue += order.price
              if order.status is "delivered"
                delivered++
          for visit in controller.listOfVisits
            if visit.date is search
              visits++
              if visit.user then users++
          count: count
          delivered: delivered
          revenue: revenue
          visits: visits
          users: users

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
              visits: 0
              users: 0
          else
            label = interval.label
            interval.current++
          for info in ["count", "delivered", "revenue", "visits", "users"]
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
            visit:
              series: ["line-uniqe-visits", "line-uniqe-users"]
              data: [[], []]

          for label, data of intervals
            labels.push label
            charts.count.data[0].push data.count
            charts.count.data[1].push data.delivered
            charts.revenue.data[0].push data.revenue
            charts.visit.data[0].push data.visits
            charts.visit.data[1].push data.users

          for chart in ["count", "revenue", "visit"]
            charts[chart].labels = labels

          charts

        controller.charts = buildCharts()

        $scope.$on "$destroy", stop

  controller.doAction = (event, order) ->
    showDescriptionService event,
      info:
        id: order._id
        status: order.status
        admin: yes
        user: order.user._id

  init()

  controller
