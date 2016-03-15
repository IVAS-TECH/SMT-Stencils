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
    
    scope.frame = (frame, none = "stencil") -> if scope.scopeCtrl.configurationObject.style.frame then frame else none

directive.$inject = ["scopeControllerService"]

module.exports = directive