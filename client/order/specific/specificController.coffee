module.exports = (Upload) ->
  controller = @
  controller.$inject = ["Upload"]
  controller.files = []
  controller.top =
    text: ""
    view: ""
  controller.bottom =
    text: ""
    view: ""
  controller.upload = ->
    upload = Upload.upload
      url: "client/preview"
      data:
        files: controller.files
    upload.then (res) ->
      controller.top.view = controller.bottom.view = res.data.top
  controller
