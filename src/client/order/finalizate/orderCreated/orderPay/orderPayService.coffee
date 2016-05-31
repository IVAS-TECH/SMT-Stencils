service = (showDialogService, payWithPaypalService, payWithStripeService) ->
    dialog = (event, locals, extend) ->
        openSubDialog = (dialogService) ->
            -> dialogService event, locals, back: (-> dialog event, locals, extend), extend
        handle =
            payWithPaypal: openSubDialog payWithPaypalService
            payWithStripe: openSubDialog payWithStripeService
        showDialogService event, "orderPay", locals, handle, extend

    dialog

service.$inject = ["showDialogService", "payWithPaypalService", "payWithStripeService"]

module.exports = service
