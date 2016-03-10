controller = ($scope, stopLoadingService, RESTHelperService, $filter, dateService, showDescriptionService, statusOptions, notificationService, confirmService) ->
  filter = $filter "filter"
  ctrl = @
  ctrl.fromDate = new Date()
  ctrl.toDate = new Date()
  ctrl.status = statusOptions
  ctrl.listOfOrders = []

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
          indexA = ctrl.status.indexOf a.status
          indexB = ctrl.status.indexOf b.status
          notifyA = if a.notify? then 1 else 0
          notifyB = if b.notify? then 1 else 0
          index = indexA - indexB
          if not index then notifyB - notifyA else index

      ctrl.fullListOfOrders = transform yes
      ctrl.listOfOrders = ctrl.fullListOfOrders
      stopLoadingService "orders"
      listeners = ($scope.$watch "ordersCtrl." + watch, ctrl.filterFn for watch in ["filter", "fromDate", "toDate"])
      
      $scope.$on "notification", ->
        ctrl.fullListOfOrders = transform no
        ctrl.filterFn()

      $scope.$on "$destroy", -> listener() for listener in listeners

  ctrl.labels =
    _id: 25
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  ctrl.filterFn = (newValue) ->
    filtered = filter ctrl.fullListOfOrders, ctrl.filter
    ctrl.listOfOrders = filter filtered, (order) ->
      if order?
        date = dateService.parse order.orderDate
        return ctrl.toDate >= date >= ctrl.fromDate
      else no

  ctrl.compareableDate = (wich) -> ctrl[wich + "Date"] = dateService.compatible ctrl[wich + "Date"]

  ctrl.showAll = -> delete ctrl.showing

  ctrl.removeNotifcation = (order) ->
    if order.notify? then RESTHelperService.notification.remove order.notify, (res) ->
        index = ctrl.fullListOfOrders.indexOf order
        delete ctrl.fullListOfOrders[index].notify
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