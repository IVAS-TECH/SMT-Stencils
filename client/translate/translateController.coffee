module.exports = ($translate) ->
  controller = @
  controller.$inject = ["$translate"]
  controller.lenguages = ["bg", "en"]
  controller.current = $translate.use()
  controller.change = (len) -> $translate.use len
  controller
