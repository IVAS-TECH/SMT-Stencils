module.exports = ($controller, confirmService, $scope, simpleDialogService, RESTHelperService, infoOnlyService) ->
  @$inject = ["$controller", "confirmService", "$scope", "simpleDialogService", "RESTHelperService", "infoOnlyService"]
  injectable =
    "RESTHelperService": RESTHelperService
    "simpleDialogService": simpleDialogService
    "$scope": $scope
  controller = $controller "addressesInterface", injectable
  controller.settings = true

  controller.init = -> controller.getAddresses()

  controller.create = (event, invalid) -> controller.save()

  controller.edit = ->
    controller.disabled = false
    controller.action = "edit"

  controller.delete = (event) ->
      confirmService event, success: ->
        RESTHelperService.addresses.delete controller.information._id, (res) ->
          if res.success
            controller.reset()
            $scope.$digest()

  controller.update = (event, invalid) ->
    if not invalid
      confirmService event, success: ->
        RESTHelperService.addresses.update addresses: (infoOnlyService controller.information), (res) ->
          console.log res

  controller.init()

  controller
