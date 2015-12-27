module.exports = ($scope, $state, RESTHelperService, infoOnlyService) ->
  controller = @
  controller.$inject = ["$scope", "$state", "RESTHelperService", "infoOnlyService"]
  controller.disabled = true

  controller.back = -> $state.go "home.order.addresses"

  controller.order = (event) ->
    RESTHelperService.upload.order controller.files, (res) ->
      order =
        style: controller.style
        files: res.files
        topText: controller.top.text
        bottomText: controller.bottom.text
        configuration: controller.configuration
        information: infoOnlyService controller.information
      RESTHelperService.order.create order: order, (res) ->
        console.log res

  controller
