module.exports = (template, scopeControllerService) ->
  @$inject = ["template", "scopeControllerService"]
  template: template "configurationInfoView"
  restrict: "E"
  scope: controller: "="
  link: (scope, element, attrs) -> scopeControllerService scope
