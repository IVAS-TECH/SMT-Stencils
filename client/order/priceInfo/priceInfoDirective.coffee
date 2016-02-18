directive = (scopeControllerService, $state) ->

  templateUrl: "priceInfoView"
  scope: controller: "@"
  link: (scope) ->
    scopeControllerService scope
    init = ->
      scope.scopeCtrl.calculatePrice()
      scope.price = {}
      prices = ["fudicals", "size", "apertures", "text", "glued", "impregnation", "total"]
      scope.price[price] = 0 for price in prices
      interval = setTimeout (->
        console.log scope.scopeCtrl.order.price
        for price in prices
          checked = scope.scopeCtrl.order.price[price]
          if checked? then scope.price[price] = checked
        ), 10000
      return
    scope.next = -> $state.go "home.order.finalizate"
    scope.back = -> $state.go "home.order.addresses"
    init()

directive.$inject = ["scopeControllerService"]

module.exports = directive
