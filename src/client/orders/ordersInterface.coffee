controller = ($scope, stopLoadingService, RESTHelperService, $filter, dateService, showDescriptionService, statusOptions, notificationService, confirmService) ->
  filter = $filter "filter"
  ctrl = @
  ctrl.fromDate = new Date()
  ctrl.toDate = new Date()
  ctrl.status = statusOptions
  ctrl.listOfOrders = []
  ctrl.labels = _id: 25, status: 15, price: 15, orderDate: 15, sendingDate: 15

  init = ->
    RESTHelperService.order.find (res) ->
      orders = res.orders
      beggin = orders[0]
      end = orders[orders.length - 1]
      if beggin? then ctrl.toDate = dateService.compatible beggin.orderDate
      if end? then ctrl.fromDate = dateService.compatible end.orderDate

      transform = (full) ->
        transformFn = (order) ->
          if full then order[type + "Date"] = dateService.format order[type + "Date"] for type in ["order", "sending"]
          order.notify = notificationService.notificationFor order._id
          order

        (transformFn order for order in orders).sort (a, b) ->
          value = (some) -> if some.notify? then 1 else 0
          index = (ctrl.status.indexOf a.status) - (ctrl.status.indexOf b.status)
          if not index then (value a) - (value b) else index

      ctrl.fullListOfOrders = transform yes
      ctrl.listOfOrders = ctrl.fullListOfOrders
      stopLoadingService "orders"

      listeners = ($scope.$watch "ordersCtrl." + watch, ctrl.filterFn for watch in ["filter", "fromDate", "toDate"])

      $scope.$on "notification", ->
        ctrl.fullListOfOrders = transform no
        ctrl.filterFn()

      $scope.$on "$destroy", -> listener() for listener in listeners

  ctrl.filterFn = (newValue) ->
    filtered = if ctrl.filter? and ctrl.filter.length then filter ctrl.fullListOfOrders, ctrl.filter else ctrl.fullListOfOrders
    if ctrl.toDate < ctrl.fromDate then [ctrl.fromDate, ctrl.toDate] = [ctrl.toDate, ctrl.fromDate]
    ctrl.listOfOrders = filter filtered, (order) ->
      if order? then ctrl.toDate >= (dateService.parse order.orderDate) >= ctrl.fromDate else no

  ctrl.compareableDate = (wich) -> ctrl[wich + "Date"] = dateService.compatible ctrl[wich + "Date"]

  ctrl.showAll = -> delete ctrl.showing

  ctrl.removeNotifcation = (order) ->
    if order.notify? then notificationService.removeNotification order.notify, (res) ->
        delete ctrl.fullListOfOrders[ctrl.fullListOfOrders.indexOf order].notify
        delete order.notify

  ctrl.choose = (event, order) ->

    checkForDescription = ->
      RESTHelperService.description.find order._id, (res) ->
        if res.description? then showDescriptionService event, info: res.description

    ctrl.showing = order._id

    RESTHelperService.order.view files: order.files, (res) ->
      $scope.order = order
      $scope.order[layer] = text: order[layer + "Text"], view: res[layer] for layer in ["top", "bottom"]
      if ctrl.afterChoose? then ctrl.afterChoose event, order, res, checkForDescription
      else checkForDescription()

  ctrl.doAction = (event, order) ->
    if order.status is "rejected"
      confirmService event, success: ->
        RESTHelperService.order.remove order._id, (res) ->
          for list in ["listOfOrders", "fullListOfOrders"]
            index = ctrl[list].indexOf order
            ctrl[list].splice index, 1

  ctrl.statusHelp = (order, equals) -> order.status is "accepted" or order.status is "rejected"

  init()

  ctrl

controller.$inject = ["$scope", "stopLoadingService", "RESTHelperService", "$filter", "dateService", "showDescriptionService", "statusOptions", "notificationService", "confirmService"]

module.exports = controller
