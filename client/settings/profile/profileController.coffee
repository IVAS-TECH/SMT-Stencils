module.exports = ($scope, confirmService, RESTHelperService, simpleDialogService) ->
  @$inject = ["$scope", "confirmService", "RESTHelperService", "simpleDialogService"]

  controller = @

  controller.change = (event, type, valid) ->
    if valid
      confirmService event, success: ->
        RESTHelperService.user.profile type: type, value: controller.user[type], (res) ->
          simpleDialogService event, "title-changed-#{type}"

  controller.remove = (event) ->
    confirmService event, success: ->
      RESTHelperService.user.remove "id", (res) ->
        simpleDialogService event, "title-account-deleted", success: ->
          $scope.$emit "remove-account"

  controller
