module.exports = ($translateProvider) ->
  @$inject = ["$translateProvider"]

  $get: -> $translateProvider

  add: (en, bg) ->
    $translateProvider.translations "en", en
    $translateProvider.translations "bg", bg
