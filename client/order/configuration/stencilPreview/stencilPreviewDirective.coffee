directive = (template, scopeControllerService) ->

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


directive.$inject = ["template", "scopeControllerService"]

module.exports = directive
