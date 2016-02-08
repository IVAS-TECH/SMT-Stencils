controller = (RESTHelperService, confirmService, simpleDialogService) ->

  ctrl = @

  ctrl.accessValues = ["file-view", "order-menage", "admin-menage"]

  init = ->

    RESTHelperService.admin.find (res) -> ctrl.listOfAdmins = res.adminList

  init()

  ctrl.removeAdmin = (admin) ->
    confirmService {}, success: ->
      RESTHelperService.admin.remove admin, (res) ->
        simpleDialogService {}, "title-admin-removed"

  ctrl.changeAccess = (event, admin) ->
    confirmService event, success: ->
      RESTHelperService.admin.update admin: admin, (res) ->
        simpleDialogService event, "title-admin-access-changed"

  ctrl

controller.$inject = ["RESTHelperService", "confirmService", "simpleDialogService"]

module.exports = controller
