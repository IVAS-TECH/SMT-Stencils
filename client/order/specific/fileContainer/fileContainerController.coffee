module.exports = (simpleDialogService, RESTHelperService) ->
  @$inject = ["simpleDialogService", "RESTHelperService"]

  controller = @

  controller.removeFile = (event) ->
    if controller.remove
      event.stopPropagation()
      delete controller.order.files[controller.layer]
      delete controller.file

  controller.fileName = ->
    if typeof controller.file is "object"
      return controller.file.name
    else
      return (controller.file.split "___")[2]

  controller.upload = () ->
    if typeof controller.file is "object" and controller.file?
      if controller.file.size < 100000
        controller.order.files[controller.layer] = controller.file
        RESTHelperService.upload.preview controller.order.files, (res) ->
          controller.order.top.view = res.top
          controller.order.bottom.view = res.bottom
      else simpleDialogService {}, "title-wrong-file-size"

  controller
