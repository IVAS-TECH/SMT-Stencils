module.exports = ($rootScope, $scope, RESTHelperService, getStatusOptionsService, confirmService, simpleDialogService) ->
  @$inject = ["$rootScope", "$scope", "RESTHelperService", "getStatusOptionsService", "confirmService", "simpleDialogService"]

  controller = @

  init = ->
    if controller.info.admin

      controller.adminPanel = "orderMenageView"
      controller.statusOptions = getStatusOptionsService()
      controller.statusOptions.push "delete"

      RESTHelperService.language.find controller.info.user, (res) ->
        controller.info.language = res.language
        $scope.$digest()

  controller.action = (event) ->
    if controller.info.admin
      if controller.info.status is "delete"
        confirmService event, success: ->
          RESTHelperService.user.remove controller.info.user, (res) ->
            simpleDialogService event, "title-deleted", success: ->
              $rootScope.$broadcast "user-removed", controller.info.user
      else RESTHelperService.order.update controller.info, (res) ->
    controller.hide "success"

  init()

  controller
