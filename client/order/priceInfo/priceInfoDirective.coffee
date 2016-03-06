directive = (scopeControllerService, $interval, progressService) ->

  templateUrl: "priceInfoView"
  scope: controller: "@"
  link: (scope) ->
  
    scopeControllerService scope
    
    progress = progressService()

    init = ->
      scope.scopeCtrl.calculatePrice()
      scope.price = {}
      scope.progress = 0
      update = {}
      prices = ["fudicals", "size", "apertures", "text", "glued", "impregnation", "total"]
      count = 0
      times = 5
      for price in prices
        scope.price[price] = 0
        checked = scope.scopeCtrl.order.price[price]
        update[price] = if checked then (parseFloat checked / times).toFixed 2 else 0.00
      interval = $interval (->
        count++
        scope.progress = 20 * count
        if count is times
          $interval.cancel interval
          scope.hide = yes
          for price in prices
            checked = scope.scopeCtrl.order.price[price]
            if checked then scope.price[price] = checked
          scope.scopeCtrl.price = scope.scopeCtrl.order.price.total
        else scope.price[price] = (parseFloat update[price] * count).toFixed 2 for price in prices
        ), 400
      return

    scope.next = progress.next

    scope.back = progress.back

    init()

directive.$inject = ["scopeControllerService", "$interval", "progressService"]

module.exports = directive
