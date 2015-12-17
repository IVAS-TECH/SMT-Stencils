module.exports = ($scope, $state) ->
  controller = @
  controller.$inject = ["$scope", "$state"]
  controller.delivery = {}
  controller.invoice = {}
  controller.firm = {}

  controller.back = -> $state.go "home.order.specific"

  #controller.next = -> $state.go "home.order.finalizate"

  controller
