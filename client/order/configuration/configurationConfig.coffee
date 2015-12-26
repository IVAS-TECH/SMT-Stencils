module.exports = (progressServiceProvider) ->
  @$inject = ["progressServiceProvider"]

  progressServiceProvider.setState "home.order"
