module.exports = (template, scopeControllerService) ->
  @$inject = ["template", "scopeControllerService"]

  template: template "configurationInfoView"
  restrict: "E"
  scope: controller: "="
  link: (scope, element, attrs) ->

    scopeControllerService scope

    stop = scope.$watch "configuration.$valid", (value) ->
      scope.$emit "config-validity", value
    scope.$on "$destroy", stop
