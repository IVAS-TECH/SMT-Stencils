module.exports = ($scope, RESTHelperService, getStatusOptionsService) ->
  @$inject = ["$scope", "RESTHelperService", "getStatusOptionsService"]

  controller = @

  controller.info = controller.info

  init = ->
    if controller.info.admin

      controller.adminPanel = "orderMenageView"
      controller.statusOptions = getStatusOptionsService()

      RESTHelperService.language.find user: controller.info.user, (res) ->
        controller.info.language = res.language
        $scope.$digest()

  controller.action = ->
    if controller.info.admin
      RESTHelperService.order.update controller.info, (res) ->
    controller.hide "success"

  init()

  controller
