provider = ($translateProvider) ->

  $get: ->

  add: (en, bg) ->
    $translateProvider.translations "en", en
    $translateProvider.translations "bg", bg

provider.$inject = ["$translateProvider"]

module.exports = provider
