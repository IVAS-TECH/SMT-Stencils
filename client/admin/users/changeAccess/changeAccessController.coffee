controller = (RESTHelperService, confirmService) ->

  ctrl = @

  ctrl.accessValues = ["no-access", "file-view", "order-menage", "admin-menage"]

  ctrl.changeAccess = (event) ->
    confirmService event, success: ->
      RESTHelperService.user.profile id: ctrl.user._id, admin: ctrl.user.admin, (res) ->
        ctrl.hide "success"

  ctrl

controller.$inject = ["RESTHelperService", "confirmService"]

module.exports = controller
