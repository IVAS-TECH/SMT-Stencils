module.exports = ($compile, template) ->
  @$inject = ["$compile", "template"]
  restrict: "E"
  scope:
    include: "="
  link: (scope, element, attrs) ->
    compile = (html) ->
      element.html html
      compileFn = $compile element.contents()
      compileFn scope
    scope.x = scope.$parent.$parent.x ? scope.$parent.x
    if attrs.template is "true"
      compile template scope.include
    else
      scope.$watch "include", compile
