module.exports = (en, bg) ->

  config = (translateProvider) -> translateProvider.add en, bg

  config.$inject = ["translateProvider"]

  config
