module.exports = (RESTHelperService, getStatusOptionsService) ->
  @$inject = ["RESTHelperService", "getStatusOptionsService"]

  controller = @

  if controller.admin
    controller.adminPanel = "orderMenageView"
    controller.statusOptions = getStatusOptionsService()

  controller.action = ->
    if controller.admin
      description =
        order: controller.id
        text: controller.text
        status: controller.status
        price: controller.price
      console.log description
      #RESTHelperService.description.add description: description, (res) ->
    controller.hide "success"

  controller
