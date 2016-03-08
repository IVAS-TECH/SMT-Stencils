controller = (simpleDialogService, RESTHelperService, $window) ->

  ctrl = @

  ctrl.file = ctrl.order.files[ctrl.layer]

  ctrl.preview = ->
    ctrl.order.invalid = (not ctrl.order.files.top? and not ctrl.order.files.bottom?)
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
      ctrl.preview()
    else
      $window.open "api/order/download/#{ctrl.file}", ctrl.fileName()
      return

  ctrl.fileName = -> if typeof ctrl.file is "object" then ctrl.file.name else (ctrl.file.split "___")[2]

  ctrl.upload = ->
    if typeof ctrl.file is "object" and ctrl.file?
      if ctrl.file.size < 1000000
        ctrl.order.files[ctrl.layer] = ctrl.file
        ctrl.preview()
      else simpleDialogService {}, "title-wrong-file-size"

  ctrl

controller.$inject = ["simpleDialogService", "RESTHelperService", "$window"]

module.exports = controller