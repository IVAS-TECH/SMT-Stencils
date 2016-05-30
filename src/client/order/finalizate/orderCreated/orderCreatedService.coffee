service = (showDialogService, orderPayService) ->
    dialog = (event, locals, extend) ->
        handle = payNow: -> orderPayService event, locals, back: (-> dialog event, locals, extend), extend
        showDialogService event, "orderCreated", locals, handle, extend

    dialog

service.$inject = ["showDialogService", "orderPayService"]

module.exports = service
