directive = ($compile, scopeControllerService) ->

  restrict: "E"
  scope:
    include: "="
    controller: "="
  link: (scope, element, attrs) ->

    compile = (html) ->
      element.html html
      ($compile element.contents()) scope

    if scope.controller?
      scopeControllerService scope

    if scope.include?

      if attrs.template is "true"
        compile "templ"#template scope.include
      else
        scope.$watch "include", compile

directive.$inject = ["$compile", "scopeControllerService"]

module.exports = directive
