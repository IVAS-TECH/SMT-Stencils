module.exports = (simpleDialogService, RESTHelperService, $window) ->
  @$inject = ["simpleDialogService", "RESTHelperService", "$window"]

  controller = @

  controller.file = controller.order.files[controller.layer]

  controller.preview = ->
    controller.order.invalid = (not controller.order.files.top? and not controller.order.files.bottom?)
    if not controller.order.ifInvalid()
      RESTHelperService.upload.preview controller.order.files, (res) ->
        for layer in ["top", "bottom"]
          console.log typeof res[layer]
          if typeof res[layer] is "string" then controller.order[layer].view = res[layer]
          else if res[layer] is null or res[layer] is no
            what = "error"
            if res[layer] is no then what = "empty"
            simpleDialogService {}, "title-#{what}-layer-#{layer}"

  controller.action = (event) ->
    event.stopPropagation()
    if controller.remove
      delete controller.order.files[controller.layer]
      delete controller.file
      if controller.layer isnt "outline" and controller.order[controller.layer].view?
        delete controller.order[controller.layer].view
      controller.preview()
    else
      $window.open "api/order/download/#{controller.file}", controller.fileName()
      return

  controller.fileName = ->
    if typeof controller.file is "object" then controller.file.name
    else (controller.file.split "___")[2]

  controller.upload = ->
    if typeof controller.file is "object" and controller.file?
      if controller.file.size < 1000000
        controller.order.files[controller.layer] = controller.file
        controller.preview()
      else simpleDialogService {}, "title-wrong-file-size"

  controller
