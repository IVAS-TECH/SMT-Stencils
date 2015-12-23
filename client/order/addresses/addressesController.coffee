module.exports = ($scope, progressService, simpleDialogService, RESTHelperService) ->
  controller = @
  controller.$inject = ["$scope", "progressService", "simpleDialogService", "RESTHelperService"]
  controller.invalid = []

  controller.init = ->
    $scope.$on "address-validity", (event, wich, value) ->
      index = -1
      switch wich
        when "delivery" then index = 0
        when "invoice" then index = 1
        when "firm" then index = 2
      controller.invalid[index] = value

  controller.getAddresses = ->
    RESTHelperService.addresses.find (res) ->
      if res.success
        controller.listOfAddresses = res.addresses

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
    controller.information = controller.listOfAddresses[controller.address]

  controller.create = ->

  controller.doAction = (event) ->
    if not (controller.invalid.every (element) -> element is true)
      if controller.action is "create"
        controller.create()
      if controller.action is "edit"
        controller.update event
    else simpleDialogService event, "required-fields"

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
    info = [
      "country"
      "city"
      "postcode"
      "address1"
      "address2"
      "firstname"
      "lastname"
    ]
    for key in info
      controller.information[src][key] =  controller.information[dst][key]

  controller.init()

  controller
