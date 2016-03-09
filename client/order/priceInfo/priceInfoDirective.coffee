directive = (scopeControllerService, $interval, progressService, listOfPrices) ->

  templateUrl: "priceInfoView"
  scope: controller: "@"
  link: (scope) ->
    scopeControllerService scope
    
    progress = progressService()
    
    init = ->
      scope.hide = scope.scopeCtrl.prices?
      if scope.hide then scope.price = scope.scopeCtrl.prices
      else
        scope.scopeCtrl.calculatePrice()
        scope.price = {}
        scope.progress = 0
        update = {}
        count = 0
        times = 5
        update[price] = (parseFloat scope.scopeCtrl.order.price[price] / times).toFixed 2 for price in listOfPrices
        interval = $interval (->
            count++
            scope.progress = 20 * count
            if count is times
              $interval.cancel interval
              scope.hide = yes
              scope.price[price] = scope.scopeCtrl.order.price[price] for price in listOfPrices
              scope.scopeCtrl.prices = scope.price
              scope.scopeCtrl.price = scope.scopeCtrl.order.price.total
            else scope.price[price] = (parseFloat update[price] * count).toFixed 2 for price in listOfPrices
        ), 400
        return
     
    scope[move] = progress[move] for move in ["next", "back"]

    init()

directive.$inject = ["scopeControllerService", "$interval", "progressService", "listOfPrices"]

module.exports = directive