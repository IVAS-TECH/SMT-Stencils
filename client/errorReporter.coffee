decorator = ($delegate, $injector) ->
  (err, cause) ->
    REST = $injector.get "REST"
    sender = REST "client-error"
    stack = err
    if err? and err.stack? then stack = err.stack
    sender.post error: stack

decorator.$inject = ["$delegate", "$injector"]

module.exports = decorator
