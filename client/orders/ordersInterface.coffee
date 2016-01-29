module.exports = ($scope, RESTHelperService, $filter, dateService, showDescriptionService, getStatusOptionsService, notificationService, confirmService) ->
  @$inject = ["$scope", "RESTHelperService", "$filter", "dateService", "showDescriptionService", "getStatusOptionsService", "notificationService", "confirmService"]

  filter = $filter "filter"

  controller = @

  controller.fromDate = new Date()

  controller.toDate = new Date()

  controller.status = getStatusOptionsService()

  controller.listOfOrders = []

  init = ->

    RESTHelperService.order.find (res) ->

      orders = res.orders

      controller.fromDate = dateService.compatible orders[orders.length - 1].orderDate

      controller.toDate = dateService.compatible orders[0].orderDate

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

        controller.fullListOfOrders = (fn order for order in orders).sort (a, b) ->
          indexA = controller.status.indexOf a.status
          indexB = controller.status.indexOf b.status
          notifyA = if a.notify? then 1 else 0
          notifyB = if b.notify? then 1 else 0
          index = indexA - indexB
          if not index
            notifyB - notifyA
          else index

      controller.listOfOrders = controller.fullListOfOrders

      transform yes

      listeners = ($scope.$watch "ordersCtrl." + watch, controller.filterFn for watch in ["filter", "fromDate", "toDate", "showing"])

      $scope.$on "notification", ->
        transform no
        controller.filterFn()

      $scope.$on "$destroy", -> listener() for listener in listeners

      $scope.$digest()

  controller.labels =
    _id: 25
    status: 15
    price: 15
    orderDate: 15
    sendingDate: 15

  controller.filterFn = (newValue) ->
    filtered = filter controller.fullListOfOrders, controller.filter
    controller.listOfOrders = filter filtered, (order) ->
      date = dateService.parse order.orderDate
      controller.toDate >= date >= controller.fromDate
    if controller.showing?
      controller.listOfOrders = filter controller.listOfOrders, _id: controller.showing

  controller.compareableDate = (wich) ->
    controller[wich + "Date"] = dateService.compatible controller[wich + "Date"]

  controller.showAll = -> delete controller.showing

  controller.removeNotifcation = (order) ->
    if order.notify?
      RESTHelperService.notification.remove order.notify, (res) ->
        index = controller.fullListOfOrders.indexOf order
        delete controller.fullListOfOrders[index].notify
        delete order.notify

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
        showDescriptionService event, {info: res.description}, success: choose
      else choose()

  controller.doAction = (event, order) ->

    if order.status is "rejected"
      confirmService event, success: ->
        RESTHelperService.order.delete order._id, (res) ->
          remove = (list) ->
            index = controller[list].indexOf order
            controller[list].splice index, 1
          remove list for list in ["listOfOrders", "fullListOfOrders"]

  init()

  controller
