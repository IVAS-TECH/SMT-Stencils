controller = ($scope, $state, RESTHelperService, simpleDialogService) ->

  ctrl = @

  ctrl.back = -> $state.go "home.order.addresses"

  ctrl.makeOder = ->
    order = {}
    order[part] = ctrl[part] for part in ["configurationObject", "addressesObject", "specific"]
    order[text + "Text"] = ctrl[text].text for text in ["top", "bottom"]

  ctrl.calculatedPrice = ->
    

  ctrl.order = (event) ->
    RESTHelperService.upload.order ctrl.files, (res) ->
      ctrl.order.files = res.files
      RESTHelperService.order.create order: ctrl.order, (res) ->
        simpleDialogService event, "title-order-created"

  ctrl

controller.$inject = ["$scope", "$state", "RESTHelperService", "simpleDialogService"]

module.exports = controller
