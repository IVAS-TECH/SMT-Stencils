directive = (scopeControllerService, $state) ->

  templateUrl: "priceInfoView"
  scope: controller: "@"
  link: (scope) ->
    scopeControllerService scope

    init = ->
      scope.scopeCtrl.calculatePrice()
      scope.price = {}
      update = {}
      prices = ["fudicals", "size", "apertures", "text", "glued", "impregnation", "total"]
      count = 0
      times = 5
      for price in prices
        scope.price[price] = 0
        checked = scope.scopeCtrl.order.price[price]
        update[price] = if checked? then (parseFloat checked / times).toFixed 2 else 0
      interval = setInterval (->
        count++
        if count is times
          clearInterval interval
          for price in prices
            checked = scope.scopeCtrl.order.price[price]
            if checked? then scope.price[price] = checked
        else scope.price[price] = update[price] * count for price in prices
        scope.$digest()
        ), 500
      return

    scope.next = -> $state.go "home.order.finalizate"

    scope.back = -> $state.go "home.order.addresses"

    init()

directive.$inject = ["scopeControllerService", "$state"]

module.exports = directive
