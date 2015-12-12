module.exports = (Upload) ->
  controller = @
  controller.$inject = ["Upload"]
  controller.files = []
  controller.upload = ->
    Upload.upload
      url: "client/preview"
      data:
        files: controller.files
  controller
