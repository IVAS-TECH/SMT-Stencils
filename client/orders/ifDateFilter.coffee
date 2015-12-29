module.exports = ($mdDateLocale) ->
  @$inject = ["$mdDateLocale"]

  (input) ->
    if input instanceof Date then $mdDateLocale.formatDate input else input
