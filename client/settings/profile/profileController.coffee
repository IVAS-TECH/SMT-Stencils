controller = ($scope, confirmService, RESTHelperService, simpleDialogService) ->

  ctrl = @

  ctrl.change = (event, type, valid) ->
    if valid
      confirmService event, success: ->
        send = id: "id", user: "#{type}": ctrl.user[type]
        RESTHelperService.user.profile send, (res) ->
          simpleDialogService event, "title-changed-#{type}"

  ctrl.remove = (event) ->
    confirmService event, success: ->
      RESTHelperService.user.remove "id", (res) ->
        simpleDialogService event, "title-account-deleted", success: ->
          $scope.$emit "remove-account"

  ctrl

controller.$inject = ["$scope", "confirmService", "RESTHelperService", "simpleDialogService"]

module.exports = controller
