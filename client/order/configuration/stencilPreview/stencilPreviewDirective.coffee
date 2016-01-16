module.exports = (template, scopeControllerService) ->
  @$inject = ["template", "scopeControllerService"]

  template: template "stencilPreviewView"
  restrict: "E"
  scope:
    text: "="
    view: "="
    controller: "="
  link: (scope) ->

    scopeControllerService scope

    if typeof scope.text is "string"
      scope.text = [scope.text]
