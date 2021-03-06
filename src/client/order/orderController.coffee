controller = (progressService, RESTHelperService, orderPriceCalculatorService, orderCreatedService) ->
    ctrl = @

    ctrl.back = -> (progressService()).back()

    ctrl.calculatePrice = ->
        ctrl.order = {}
        ctrl.order[part] = ctrl[part] for part in ["configurationObject", "addressesObject", "specific", "apertures"]
        ctrl.order[text + "Text"] = ctrl[text].text for text in ["top", "bottom"]
        ctrl.order.price = orderPriceCalculatorService ctrl.order

    ctrl.makeOrder = (event) ->
        RESTHelperService.upload.order ctrl.files, (res) ->
            ctrl.order.files = res.files
            ctrl.order.price = ctrl.price
            RESTHelperService.order.create order: ctrl.order, (res) -> orderCreatedService event, id: res._id

    ctrl

controller.$inject = ["progressService", "RESTHelperService", "orderPriceCalculatorService", "orderCreatedService"]

module.exports = controller
