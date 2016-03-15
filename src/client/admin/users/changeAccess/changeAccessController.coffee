controller = (RESTHelperService, confirmService, simpleDialogService) ->
  ctrl = @
  ctrl.accessValues = ["no-access", "file-view", "order-menage", "admin-menage"]

  ctrl.changeAccess = ->
    confirmService {}, success: ->
      user = id: ctrl.user._id, user: admin: ctrl.user.admin
      RESTHelperService.user.profile user, (res) -> simpleDialogService {}, "title-access-updated"

  ctrl

controller.$inject = ["RESTHelperService", "confirmService", "simpleDialogService"]

module.exports = controller