en = require "./language-en"
bg = require "./language-bg"

config = (translateProvider, $translateProvider) ->

  translateProvider.add en, bg

  $translateProvider.use "bg"

  $translateProvider.useSanitizeValueStrategy "escape"

config.$inject = ["translateProvider", "$translateProvider"]

module.exports = config
