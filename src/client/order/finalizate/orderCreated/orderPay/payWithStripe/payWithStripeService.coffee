service = (showDialogService) -> (event, locals, extend) -> showDialogService event, "payWithStripe", locals, {}, extend

service.$inject = ["showDialogService"]

module.exports = service
