directive = ($compile, $templateCache, scopeControllerService) ->

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
        compile $templateCache.get scope.include
      else
        scope.$watch "include", compile

directive.$inject = ["$compile", "$templateCache", "scopeControllerService"]

module.exports = directive
