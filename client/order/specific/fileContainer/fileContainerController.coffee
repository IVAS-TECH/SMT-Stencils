module.exports = ($scope, simpleDialogService, RESTHelperService, $window) ->
  @$inject = ["$scope", "simpleDialogService", "RESTHelperService", "$window"]

  controller = @

  controller.file = controller.order.files[controller.layer]

  controller.preview = ->
    controller.order.invalid = (not controller.order.files.top? and not controller.order.files.bottom?)
    if not controller.order.ifInvalid()
      RESTHelperService.upload.preview controller.order.files, (res) ->
        controller.order.top.view = res.top
        controller.order.bottom.view = res.bottom

  controller.action = (event) ->
    event.stopPropagation()
    if controller.remove
      delete controller.order.files[controller.layer]
      delete controller.file
      if controller.order[controller.layer].view?
        delete controller.order[controller.layer].view
      controller.preview()
    else
      $window.open "api/order/download/#{controller.file}", controller.fileName()
      return

  controller.fileName = ->
    if typeof controller.file is "object"
      return controller.file.name
    else
      return (controller.file.split "___")[2]

  controller.upload = ->
    if typeof controller.file is "object" and controller.file?
      if controller.file.size < 100000
        controller.order.files[controller.layer] = controller.file
        controller.preview()
      else simpleDialogService {}, "title-wrong-file-size"

  controller
