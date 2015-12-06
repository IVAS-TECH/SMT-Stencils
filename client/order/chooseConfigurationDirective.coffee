module.exports = (template) ->
  @$inject = ["template"]
  restrict: "E"
  scope: false
  template: template "chooseConfigurationView"
  link: (scope, element, attrs) ->
    controller = scope.$parent.x ? scope.x
    controller.text = "Text"
    controller.view = template "top"
    if attrs.settings is "false"
      controller.settings = false
    else
      controller.settings = true
