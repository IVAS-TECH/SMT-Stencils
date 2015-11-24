module.exports = ($translate) ->
  translate = @
  translate.$inject = ["$translate"]
  translate.lenguages = ["bg", "en"]
  translate.change = (len) -> $translate.use len
  translate
