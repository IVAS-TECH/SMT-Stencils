Service.$inject = ['$mdDialog'];

function Service ($mdDialog) {
  function showDialog(content) {
    var Dialog = $mdDialog.alert();
    Dialog.content(content);
    Dialog.ok('OK');

    $mdDialog.show(Dialog);
  }

  return showDialog;
}

var serviceName = 'AppShowDialog',
  appShowDialogService = {};

appShowDialogService.serviceName = serviceName;
appShowDialogService.service = Service;

export var appShowDialogService = appShowDialogService;
