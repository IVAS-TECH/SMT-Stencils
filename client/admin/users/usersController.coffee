controller = (accessValues, RESTHelperService, confirmService, simpleDialogService) ->

  ctrl = @

  ctrl.accessValues = accessValues

  init = ->

    RESTHelperService.user.find (res) -> ctrl.listOfUsers = res.users

  ctrl.changeAccess = (user) ->
    confirmService {}, success: ->
      RESTHelperService.user.profile id: user._id, admin: user.admin, (res) ->
        simpleDialogService {}, "title-user-access-changed"

  ctrl.removeAdmin = (event, user) ->
    confirmService event, success: ->
      RESTHelperService.user.remove user._id, (res) ->
        simpleDialogService event, "title-user-removed"

  init()

  ctrl

controller.$inject = ["accessValues", "RESTHelperService", "confirmService", "simpleDialogService"]

module.exports = controller
