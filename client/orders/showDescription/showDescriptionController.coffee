module.exports = ($scope, RESTHelperService, getStatusOptionsService) ->
  @$inject = ["$scope", "RESTHelperService", "getStatusOptionsService"]

  controller = @

  if controller.admin
    controller.adminPanel = "orderMenageView"
    controller.statusOptions = getStatusOptionsService()
    RESTHelperService.language.find user: controller.user, (res) ->
      controller.language = res.language
      $scope.$digest()

  controller.action = ->
    if controller.admin
      description = {}
      for copy in ["id", "text", "status", "user", "language", "price"]
        description[copy] = controller[copy]
      RESTHelperService.order.update description, (res) ->
    controller.hide "success"

  controller
