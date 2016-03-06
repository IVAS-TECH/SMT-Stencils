directive = (scopeControllerService) ->

  templateUrl: "stencilPreviewView"
  restrict: "E"
  scope:
    text: "="
    view: "="
    controller: "="
  link: (scope) ->
  
    scopeControllerService scope

    if typeof scope.text is "string" then scope.text = [scope.text]


directive.$inject = ["scopeControllerService"]

module.exports = directive
