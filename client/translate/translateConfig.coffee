en = require "./language-en"
bg = require "./language-bg"

module.exports = (translateProvider) ->
  @$inject = ["translateProvider"]

  translateProvider.add en, bg

  $translateProvider = translateProvider.$get()

  $translateProvider.use "bg"

  $translateProvider.useSanitizeValueStrategy "escape"
