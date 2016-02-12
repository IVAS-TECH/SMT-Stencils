controller = (RESTHelperService, confirmService, simpleDialogService, changeAccessService) ->

  ctrl = @

  init = ->

    RESTHelperService.user.find (res) -> ctrl.listOfUsers = res.users

  ctrl.changeAccess = (event, user) ->
    changeAccessService event, user: user, success: ->
      simpleDialogService event, "title-user-access-changed"

  ctrl.removeAdmin = (event, user) ->
    confirmService event, success: ->
      RESTHelperService.user.remove user._id, (res) ->
        simpleDialogService event, "title-user-removed"

  init()

  ctrl

controller.$inject = ["RESTHelperService", "confirmService", "simpleDialogService", "changeAccessService"]

module.exports = controller
