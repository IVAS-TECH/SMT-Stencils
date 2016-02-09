decorator = ($delegate, $injector, errorsLogResource) ->

  (err) ->
    RESTService = $injector.get "RESTService"
    sender = RESTService errorsLogResource
    stack = err
    if err? and err.stack? then stack = err.stack
    sender.post error: stack

decorator.$inject = ["$delegate", "$injector", "errorsLogResource"]

module.exports = decorator
