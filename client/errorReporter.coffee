decorator = ($delegate, $injector, errorsLogResource) ->

  (err) -> ((($injector.get "RESTService") errorsLogResource) "post") error: if err? and err.stack? then err.stack else err

decorator.$inject = ["$delegate", "$injector", "errorsLogResource"]

module.exports = decorator
