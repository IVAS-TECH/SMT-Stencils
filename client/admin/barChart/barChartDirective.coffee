{angular} = require "dependencies"

directive = ($templateCache, $compile, $window) ->

  templateUrl: "barChartView"
  scope: chart: "="
  link: (scope, element, attrs) ->
    wrapper = element.children()

    resize = ->
      wrapper.html $templateCache.get "barChart"
      ($compile wrapper.contents()) scope
      canvas = wrapper.find "canvas"
      part = width: 4, height: 2
      canvas.prop prop, $window.screen[prop] * value / 5 for prop, value of part

    resize()

    (angular.element $window).on "resize", resize

directive.$inject = ["$templateCache", "$compile", "$window"]

module.exports = directive