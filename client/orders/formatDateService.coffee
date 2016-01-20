module.exports = ($filter) ->
  @$inject = ["$filter"]

  (date) ->
    ($filter "date") (new Date date), "dd/MM/yyyy"
