controller = ($state, RESTHelperService, simpleDialogService, orderPriceCalculatorService) ->

  ctrl = @

  ctrl.back = -> $state.go "home.order.price"

  ctrl.calculatePrice = ->
    ctrl.order = {}
    ctrl.order[part] = ctrl[part] for part in ["configurationObject", "addressesObject", "specific", "apertures"]
    ctrl.order[text + "Text"] = ctrl[text].text for text in ["top", "bottom"]
    ctrl.order.price = orderPriceCalculatorService ctrl.order

  ctrl.order = (event) ->
    RESTHelperService.upload.order ctrl.files, (res) ->
      ctrl.order.files = res.files
      ctrl.order.price = ctrl.order.price.total
      RESTHelperService.order.create order: ctrl.order, (res) ->
        simpleDialogService event, "title-order-created"

  ctrl

controller.$inject = ["$state", "RESTHelperService", "simpleDialogService", "orderPriceCalculatorService"]

module.exports = controller
