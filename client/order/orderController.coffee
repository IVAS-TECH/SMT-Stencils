controller = ($scope, $state, RESTHelperService, simpleDialogService) ->

  ctrl = @

  ctrl.back = -> $state.go "home.order.addresses"

  ctrl.order = (event) ->
    RESTHelperService.upload.order ctrl.files, (res) ->
      order =
        files: res.files
        topText: ctrl.top.text
        bottomText: ctrl.bottom.text
        configurationObject: ctrl.configurationObject
        addressesObject: ctrl.addressesObject
      RESTHelperService.order.create order: order, (res) ->
        simpleDialogService event, "title-order-created"

  ctrl

controller.$inject = ["$scope", "$state", "RESTHelperService", "simpleDialogService"]

module.exports = controller
