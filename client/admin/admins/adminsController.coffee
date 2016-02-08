controller = (accessValues, RESTHelperService, confirmService, simpleDialogService) ->

  ctrl = @

  ctrl.accessValues = accessValues

  init = ->

    RESTHelperService.admin.find (res) -> ctrl.listOfAdmins = res.adminList

  ctrl.changeAccess = (admin) ->
    confirmService {}, success: ->
      RESTHelperService.admin.update admin: admin, (res) ->
        simpleDialogService {}, "title-admin-access-changed"

  ctrl.removeAdmin = (event, admin) ->
    confirmService event, success: ->
      RESTHelperService.admin.remove admin._id, (res) ->
        simpleDialogService event, "title-admin-removed"

  init()

  ctrl

controller.$inject = ["accessValues", "RESTHelperService", "confirmService", "simpleDialogService"]

module.exports = controller
