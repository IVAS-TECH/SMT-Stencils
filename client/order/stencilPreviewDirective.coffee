module.exports = (template) ->
  @$inject = ["template"]
  template: template "stencilPreviewView"
  restrict: "E"
  scope: false
  controller: ->
  controllerAs: "stencilCtrl"
  bindToController: {
    text: "="
    view: "="
  }
