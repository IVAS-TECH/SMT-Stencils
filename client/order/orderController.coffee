module.exports = ($scope, RESTHelperService, infoOnlyService) ->
  controller = @
  controller.$inject = ["$scope", "RESTHelperService", "infoOnlyService"]
  controller.disabled = true

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
