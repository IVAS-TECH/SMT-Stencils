{angular} = require "dependencies"

directive = ($templateCache, $compile, $window, $timeout) ->
    templateUrl: "barChartView"
    scope: chart: "="
    link: (scope, element, attrs) ->
        resize = ->
            wrapper = element.children()
            wrapper.html $templateCache.get "barChart"
            ($compile wrapper.contents()) scope
            canvas = wrapper.find "canvas"
            part = width: 4, height: 2
            canvas.prop prop, $window.screen[prop] * value / 5 for own prop, value of part
        resize()
        $timeout resize, 5000
        (angular.element $window).on "resize", resize

directive.$inject = ["$templateCache", "$compile", "$window", "$timeout"]

module.exports = directive
