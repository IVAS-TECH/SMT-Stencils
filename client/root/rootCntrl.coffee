module.exports = ($state) ->
  root = @
  root.$inject = ["$state"]
  root.buttons = ["About Us", "Technologies0", "Order", "Contacts", "Settings"]
  root.selected = [true, false, false, false, false]
  root.switchState = (state) ->
    states = ["about", "tech", "order", "contact", "settings"]
    index = root.buttons.indexOf state
    root.selected = [false, false, false, false, false]
    root.selected[index] = true
    $state.go states[index]
