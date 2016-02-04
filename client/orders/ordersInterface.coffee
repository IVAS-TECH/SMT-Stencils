controller = ($scope, RESTHelperService, $filter, dateService, showDescriptionService, statusOptions, notificationService, confirmService) ->

  filter = $filter "filter"

  ctrl = @

  ctrl.fromDate = new Date()

  ctrl.toDate = new Date()

  ctrl.status = statusOptions

  ctrl.listOfOrders = []

  init = ->

    RESTHelperService.order.find (res) ->

      orders = res.orders

      ctrl.fromDate = dateService.compatible orders[orders.length - 1].orderDate

      ctrl.toDate = dateService.compatible orders[0].orderDate

      transform = (full) ->

        addNotify = (order) ->
          order.notify = notificationService.notificationFor order._id

        transformFn = (full) ->

          (order) ->

            addNotify order

            if full
              for type in ["order", "sending"]
                date = type + "Date"
                order[date] = dateService.format order[date]

            order

        fn = transformFn full

        ctrl.fullListOfOrders = (fn order for order in orders).sort (a, b) ->
          indexA = ctrl.status.indexOf a.status
          indexB = ctrl.status.indexOf b.status
          notifyA = if a.notify? then 1 else 0
          notifyB = if b.notify? then 1 else 0
          index = indexA - indexB
          if not index
            notifyB - notifyA
          else index

      ctrl.listOfOrders = ctrl.fullListOfOrders

      transform yes

      listeners = ($scope.$watch "ordersCtrl." + watch, ctrl.filterFn for watch in ["filter", "fromDate", "toDate", "showing"])

      $scope.$on "notification", ->
        transform no
        ctrl.filterFn()

      $scope.$on "$destroy", -> listener() for listener in listeners

      $scope.$digest()

  ctrl.labels =
    _id: 25
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  ctrl.filterFn = (newValue) ->
    filtered = filter ctrl.fullListOfOrders, ctrl.filter
    ctrl.listOfOrders = filter filtered, (order) ->
      date = dateService.parse order.orderDate
      ctrl.toDate >= date >= ctrl.fromDate
    if ctrl.showing?
      ctrl.listOfOrders = filter ctrl.listOfOrders, _id: ctrl.showing

  ctrl.compareableDate = (wich) ->
    ctrl[wich + "Date"] = dateService.compatible ctrl[wich + "Date"]

  ctrl.showAll = -> delete ctrl.showing

  ctrl.removeNotifcation = (order) ->
    if order.notify?
      RESTHelperService.notification.remove order.notify, (res) ->
        index = ctrl.fullListOfOrders.indexOf order
        delete ctrl.fullListOfOrders[index].notify
        delete order.notify

  ctrl.choose = (event, order) ->

    checkForDescription = ->
      RESTHelperService.description.find order._id, (res) ->
        if res.description? then showDescriptionService event, info: res.description

    ctrl.showing = order._id

    RESTHelperService.order.view files: order.files, (res) ->
      set = (wich) -> text: order[wich + "Text"], view: res[wich]
      $scope.order = order
      $scope.order.top = set "top"
      $scope.order.bottom = set "bottom"
      $scope.$digest()

      if ctrl.afterChoose? then ctrl.afterChoose event, order, res, checkForDescription
      else checkForDescription()

  ctrl.doAction = (event, order) ->

    if order.status is "rejected"
      confirmService event, success: ->
        RESTHelperService.order.remove order._id, (res) ->
          remove = (list) ->
            index = ctrl[list].indexOf order
            ctrl[list].splice index, 1
          remove list for list in ["listOfOrders", "fullListOfOrders"]

  init()

  ctrl

controller.$inject = ["$scope", "RESTHelperService", "$filter", "dateService", "showDescriptionService", "statusOptions", "notificationService", "confirmService"]

module.exports = controller
