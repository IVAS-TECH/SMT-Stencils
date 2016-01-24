module.exports = (RESTHelperService, getStatusOptionsService) ->
  @$inject = ["RESTHelperService", "getStatusOptionsService"]

  controller = @

  if controller.admin
    controller.adminPanel = "orderMenageView"
    controller.statusOptions = getStatusOptionsService()

  controller.action = ->
    if controller.admin
      description = lenguage: "en"
      for copy in ["id", "text", "status", "price"]
        description[copy] = controller[copy]
      RESTHelperService.order.update description, (res) ->
    controller.hide "success"

  controller
