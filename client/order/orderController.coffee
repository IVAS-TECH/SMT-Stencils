module.exports = ($scope, $state, RESTHelperService, simpleDialogService) ->
  @$inject = ["$scope", "$state", "RESTHelperService", "simpleDialogService"]

  controller = @

  controller.back = -> $state.go "home.order.addresses"

  controller.order = (event) ->
    RESTHelperService.upload.order controller.files, (res) ->
      order =
        style: controller.style
        files: res.files
        topText: controller.top.text
        bottomText: controller.bottom.text
        configurationObject: controller.configurationObject
        addressesObject: controller.addressesObject
      RESTHelperService.order.create order: order, (res) ->
        simpleDialogService event, "title-order-created"

  controller
