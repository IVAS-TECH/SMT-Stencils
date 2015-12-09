module.exports = (template) ->
  @$inject = ["template"]
  restrict: "E"
  scope: false
  template: template "chooseConfigurationView"
  link: (scope, element, attrs) ->
    controller = scope.configCtrl
    controller.controller = "configCtrl"
    controller.text = "Text"
    controller.view = template "top"
    if attrs.settings is "false"
      controller.settings = false
    else
      controller.settings = true
