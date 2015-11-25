module.exports = ($translateProvider) ->
  provider = @
  provider.$inject = ["$translateProvider"]
  provider.add = (en, bg) ->
    $translateProvider.translations "en", en
    $translateProvider.translations "bg", bg
  provider.$get = -> $translateProvider
  provider
