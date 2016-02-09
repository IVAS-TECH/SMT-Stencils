decorator = ($delegate, $injector) ->
  (err, cause) ->
    RESTService = $injector.get "RESTService"
    sender = RESTService "client-error"
    stack = err
    if err? and err.stack? then stack = err.stack
    sender.post error: stack

decorator.$inject = ["$delegate", "$injector"]

module.exports = decorator
