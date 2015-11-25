module.exports = ($translateProvider) ->
  provider = @
  provider.$inject = ["$translateProvider"]
  provider.add = (en, bg) ->
    en $translateProvider
    bg $translateProvider
  provider.$get = -> $translateProvider
  provider
