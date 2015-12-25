module.exports = ($scope, RESTHelperService, infoOnlyService) ->
  controller = @
  controller.$inject = ["$scope", "RESTHelperService", "infoOnlyService"]
  controller.disabled = true

  controller.order = (event) ->
    RESTHelperService.upload.order controller.files, (res) ->
      order =
        files: res.files
        textTop: controller.top.text
        textBottom: controller.bottom.text
        configuration: controller.configuration
        information: infoOnlyService controller.information
      console.log order
      RESTHelperService.order.create order: order, (res) ->
        console.log res

  controller
