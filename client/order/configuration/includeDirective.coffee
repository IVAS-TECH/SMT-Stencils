directive = ($compile, $templateCache, scopeControllerService) ->

  restrict: "E"
  scope:
    include: "="
    controller: "="
  link: (scope, element, attrs) ->
    insertTemplate = (html) ->
      element.html html
      ($compile element.contents()) scope

    if scope.controller? then scopeControllerService scope

    if scope.include?
      if attrs.template is "true"
        insertTemplate $templateCache.get scope.include
      else scope.$watch "include", insertTemplate

directive.$inject = ["$compile", "$templateCache", "scopeControllerService"]

module.exports = directive