module.exports = (template, RESTHelperService) ->
  @$inject = ["template", "RESTHelperService"]
  restrict: "E"
  scope: false
  template: (tElement, tAttrs) ->
    if tAttrs.settings is "false"
      return template "chooseConfigurationView"
  link: (scope, element, attrs) ->
    RESTHelperService.config.find (res) ->
      if res.success
        scope.$parent.x.configs = res.configs
