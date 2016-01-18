module.exports = (RESTHelperService, $scope, progressService, simpleDialogService, showErrorService) ->
  @$inject = ["RESTHelperService", "$scope", "progressService", "simpleDialogService", "showErrorService"]

  controller = @
  controller.files = []
  controller.top = {}
  controller.bottom = {}

  progress = progressService $scope, "orderCtrl", "specificCtrl"

  controller.upload = (error) ->
    if showErrorService error
      index = 0;
      errors = Object.keys error
      show = ->
        simpleDialogService {}, "error-#{errors[index++]}", success: ->
          if index < errors.length
            show()
      show()
    else
      RESTHelperService.upload.preview controller.files, (res) ->
        controller.top.view = res.top
        controller.bottom.view = res.bottom

  controller.back = -> progress no

  controller.next = -> progress yes

  controller
