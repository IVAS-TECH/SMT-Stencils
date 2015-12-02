module.exports = ($compile, template) ->
  @$inject = ["$compile", "template"]
  restrict: "A"
  replace: true
  link: (scope, element, attrs) ->
    compile = (html) ->
      element.html html
      compileFn = $compile element.contents()
      compileFn scope
    include = scope.$eval attrs.ivoInclude
    if typeof include is "string"
      compile template include
    else
      scope.$watch include, compile
