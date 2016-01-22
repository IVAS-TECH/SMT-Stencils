{angular} = require "dependencies"

module.exports = (template, $window) ->
  @$inject = ["template"]

  template: template "lineChartView"
  scope: chart: "="
  link: (scope, element, attrs) ->
    canvas = element.find "canvas"

    resize = ->
      part =
        width: 4
        height: 2
      for dimenstion in ["width", "height"]
        canvas.prop dimenstion, $window.screen[dimenstion] * part[dimenstion] / 5

    resize()
    (angular.element $window).on "resize", ->
      resize
      canvas.triggerHandler "click"
