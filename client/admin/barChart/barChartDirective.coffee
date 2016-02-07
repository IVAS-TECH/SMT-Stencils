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

      part =
        width: 4
        height: 2

      for dimenstion in ["width", "height"]
        canvas.prop dimenstion, $window.screen[dimenstion] * part[dimenstion] / 5

    resize()

    (angular.element $window).on "resize", resize

directive.$inject = ["$templateCache", "$compile", "$window"]

module.exports = directive
