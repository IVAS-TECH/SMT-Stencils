{angular} = require "dependencies"

module.exports = ($scope, progressService) ->
  controller = @
  controller.$inject = ["$scope", "progressService"]
  controller.invalid = []

  controller.init = ->
    $scope.$on "address-validity", (event, wich, value) ->
      index = -1
      switch wich
        when "delivery" then index = 0
        when "invoice" then index = 1
        when "firm" then index = 2
      console.log wich, index, value
      controller.invalid[index] = value

  controller.reset = ->
    controller.information =
      delivery: {}
      invoice: {}
      firm: {}
    delete controller.address
    controller.disabled = false
    controller.action = "create"
    controller.show = true

  controller.choose = ->
    controller.disabled = true
    controller.action = "preview"
    controller.information = controller.addresses[controller.address]

  controller.doAction = (event) ->
    console.log controller.invalid

  properties = [
    "delivery"
    "invoice"
    "firm"
    "sameAsAbove"
    "sameAsDelivery"
    "sameAsInvoice"
  ]

  progress = progressService $scope, "orderCtrl", "addressesCtrl", properties

  controller.back = -> progress.move "specific"

  controller.next = -> progress.move "finalizate"

  controller.fill = (dst, src) ->
    for key, value of controller.information[dst]
    angular.copy controller.information[dst], controller.information[src]

  controller.init()

  controller
