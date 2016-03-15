controller = (simpleDialogService, $state, $controller, $scope, stopLoadingService, RESTHelperService, $filter, dateService, showDescriptionService, statusOptions, notificationService, confirmService) ->

  ctrl = $controller "ordersInterface",
    "$scope": $scope
    "stopLoadingService": stopLoadingService
    "RESTHelperService": RESTHelperService
    "$filter": $filter
    "dateService": dateService
    "showDescriptionService": showDescriptionService
    "statusOptions": statusOptions
    "notificationService": notificationService
    "confirmService": confirmService

  ctrl.adminPanel = "adminPanelView"

  init = ->
    RESTHelperService.visit.find (res) ->
      ctrl.listOfVisits = res.visits
      stopLoadingService "admin"
      
      stopStatistics = $scope.$watch "ordersCtrl.listOfOrders", (orders) ->
        if not orders? then return
        beggin = ctrl.fromDate
        end = ctrl.toDate
        it = dateService.iterator beggin, end
        gap = end.getMonth() - beggin.getMonth()
        years = end.getFullYear() - beggin.getFullYear() + 1
        normalizate =  Math.abs (Math.floor end.getDate() / 3) - (Math.floor beggin.getDate() / 3)
        diff = Math.abs (Math.floor ((3 * gap * years) + 3 - normalizate) / 3) + 3
        interval = current: diff, label: ""
        intervals = {}
        about = ["count", "delivered", "revenue", "visits", "users"]
        
        emptyRecord = ->
          obj = {}
          obj[stat] = 0 for stat in about
          obj

        statisticData = (search) ->
          data = emptyRecord()
          for order in orders
            if order.orderDate is search
              data.count++
              data.revenue += order.price
              if order.status is "delivered" then data.delivered++
          for visit in ctrl.listOfVisits
            if visit.date is search
              data.visits++
              if visit.user then data.users++
          data

        buildIntervals = (date) ->
          label = dateService.format date
          data = statisticData label
          if interval.current is diff
            interval.current = 0
            interval.label = label
            intervals[label] = emptyRecord()
          else
            label = interval.label
            interval.current++
          intervals[label][info] += data[info] for info in about
          
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

          charts[chart].labels = labels for chart in ["count", "revenue", "visit"]

          charts

        buildIntervals it.value while it.next()

        ctrl.charts = buildCharts()

      stopRemove = $scope.$on "user-removed", (event, user) ->
        ctrl.fullListOfOrders = ctrl.fullListOfOrders.filter (element) ->
          element? and element.user._id isnt user
        ctrl.filterFn()

      $scope.$on "$destroy", ->
        stopStatistics()
        stopRemove()

  ctrl.doAction = (event, order) ->
    info = id: order._id, status: order.status, admin: yes, user: order.user._id, price: order.price
    showDescriptionService event, {info: info}, success: -> simpleDialogService event, "title-order-status-updated"

  ctrl.afterChoose = (event, order, stencil, callback) -> if order.status is "new" then ctrl.doAction event, order else callback()

  ctrl.goToUsers = -> $state.go "home.admin.users"

  init()

  ctrl

controller.$inject = ["simpleDialogService", "$state", "$controller", "$scope", "stopLoadingService", "RESTHelperService", "$filter", "dateService", "showDescriptionService", "statusOptions", "notificationService", "confirmService"]

module.exports = controller