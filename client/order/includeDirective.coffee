module.exports = ($compile, template, scopeControllerService) ->
  @$inject = ["$compile", "template", "scopeControllerService"]
  restrict: "E"
  scope:
    include: "="
    controller: "="
  link: (scope, element, attrs) ->

    compile = (html) ->
      element.html html
      compileFn = $compile element.contents()
      compileFn scope

    scopeControllerService scope
    if attrs.template is "true"
      compile template scope.include
    else
      scope.$watch "include", compile
