controller = (accessValues, RESTHelperService, confirmService) ->

  ctrl = @

  ctrl.accessValues = accessValues

  ctrl.makeAdmin = (event) ->
    confirmService event, success: ->
      admin = user: ctrl.user._id, access: ctrl.access
      RESTHelperService.admin.post admin, (res) -> ctrl.hide "success"

  ctrl

controller.$inject = ["accessValues", "RESTHelperService", "confirmService"]

module.exports = controller
