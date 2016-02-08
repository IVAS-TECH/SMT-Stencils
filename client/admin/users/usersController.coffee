controller = ($rootScope, makeAdminService, RESTHelperService, confirmService, simpleDialogService) ->

  ctrl = @

  init = ->

    RESTHelperService.user.find (res) -> ctrl.listOfUsers = res.users

  ctrl.makeAdmin = (event, user) ->
    makeAdminService event, user: user, success: ->
      simpleDialogService "users-is-admin-now"

  ctrl.removeUser = (event, user) ->
    id = user._id
    confirmService event, success: ->
      RESTHelperService.user.remove id, (res) ->
        simpleDialogService event, "title-user-deleted", success: ->
          $rootScope.$broadcast "user-removed", id

  init()

  ctrl

controller.$inject = ["$rootScope", "makeAdminService", "RESTHelperService", "confirmService", "simpleDialogService"]

module.exports = controller
