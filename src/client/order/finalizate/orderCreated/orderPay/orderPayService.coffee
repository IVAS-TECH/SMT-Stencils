service = (showDialogService, payWithPaypalService, payWithStripesService) ->
    dialog = (event, locals, extend) ->
        openSubDialog = (dialogService) ->
            -> dialogService event, locals, back: (-> dialog event, locals, extend), extend
        handle =
            payWithPaypal: openSubDialog payWithPaypalService
            payWithStripes: openSubDialog payWithStripesService
        showDialogService event, "orderPay", locals, handle, extend

    dialog

service.$inject = ["showDialogService", "payWithPaypalService", "payWithStripesService"]

module.exports = service
