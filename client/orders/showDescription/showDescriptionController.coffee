module.exports = ($scope, RESTHelperService, getStatusOptionsService) ->
  @$inject = ["$scope", "RESTHelperService", "getStatusOptionsService"]

  controller = @

  init = ->
    if controller.info.admin

      controller.adminPanel = "orderMenageView"
      controller.statusOptions = getStatusOptionsService()

      RESTHelperService.language.find controller.info.user, (res) ->
        controller.info.language = res.language
        $scope.$digest()

  controller.action = ->
    if controller.info.admin
      RESTHelperService.order.update controller.info, (res) ->
    controller.hide "success"

  init()

  controller
