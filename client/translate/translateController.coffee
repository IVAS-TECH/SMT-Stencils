module.exports = ($translate) ->
  @$inject = ["$translate"]

  controller = @

  controller.languages = ["bg", "en"]

  controller.current = $translate.use()

  controller.change = (len) ->
    $translate.use len

  controller
