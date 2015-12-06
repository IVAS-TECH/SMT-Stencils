module.exports = (template, RESTHelperService) ->
  @$inject = ["template", "RESTHelperService"]
  restrict: "E"
  scope: false
  template: template "chooseConfigurationView"
  link: (scope, element, attrs) ->
    #if tAttrs.settings is "false" then scope.$parent.x.settings = false else true
    RESTHelperService.config.find (res) ->
      if res.success
        scope.$parent.x.configs = res.configs
