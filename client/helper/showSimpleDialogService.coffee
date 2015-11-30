module.exports = ($mdDialog) ->
  @$inject = ["$mdDialog"]
  (content) ->
    $mdDialog.show $mdDialog.alert().content(content).ok "Ok"
