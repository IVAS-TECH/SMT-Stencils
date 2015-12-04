module.exports = (template) ->
  @$inject = ["template"]
  template: template "stencilPreviewView"
  restrict: "E"
  scope: {
    text: "="
    view: "="
  }
