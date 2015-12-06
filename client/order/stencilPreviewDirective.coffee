module.exports = (template) ->
  @$inject = ["template"]
  template: template "stencilPreviewView"
  restrict: "E"
  scope: {
    text: "="
    view: "="
  }
  link: (scope) -> scope.x = scope.$parent.$parent.x ? scope.$parent.x
