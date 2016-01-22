module.exports = (template, $window) ->
  @$inject = ["template"]

  template: template "lineChartView"
  scope: chart: "="
  link: (scope, element, attrs) ->
    part =
      width: 4
      height: 2
    for dimenstion in ["width", "height"]
      scope[dimenstion] = $window.screen[dimenstion] * part[dimenstion] / 5
