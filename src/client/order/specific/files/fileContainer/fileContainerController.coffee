controller = (simpleDialogService, RESTHelperService, $window) ->

  ctrl = @

  ctrl.file = ctrl.order.files[ctrl.layer]

  preview = ->
    ctrl.order.invalid = not(ctrl.order.files.top? or ctrl.order.files.bottom?)
    if not ctrl.order.ifInvalid() then RESTHelperService.upload.preview ctrl.order.files, (res) ->
        ctrl.order.apertures = res.apertures
        for layer in ["top", "bottom"]
          if typeof res[layer] is "string" then ctrl.order[layer].view = res[layer]
          else if res[layer] is null or res[layer] is no
            what = if res[layer] is no then "empty" else "error"
            simpleDialogService {}, "title-#{what}-layer-#{layer}"

  ctrl.action = (event) ->
    event.stopPropagation()
    if ctrl.remove
      delete ctrl.order.files[ctrl.layer]
      delete ctrl.file
      if ctrl.layer isnt "outline" and ctrl.order[ctrl.layer].view? then delete ctrl.order[ctrl.layer].view
      preview()
    else
      $window.open "api/order/download/" + ctrl.file, ctrl.fileName()
      return

  ctrl.fileName = ->
    if typeof ctrl.file is "object" then return ctrl.file.name
    else
      name = (ctrl.file.split "___")[2]
      check = name.split "."
      return if check[0] is check[1] then check[0] else name

  ctrl.upload = ->
    if typeof ctrl.file is "object" and ctrl.file?
      if ctrl.file.size < 10000000
        ctrl.order.files[ctrl.layer] = ctrl.file
        preview()
      else simpleDialogService {}, "title-wrong-file-size"

  ctrl

controller.$inject = ["simpleDialogService", "RESTHelperService", "$window"]

module.exports = controller
