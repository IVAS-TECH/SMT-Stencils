Controller.$inject = ['$mdDialog', 'AppShowDialog'];

var controllerName = 'viewSettingsProfileController',
  viewSettingsProfileController = {};

function Controller($mdDialog, AppShowDialog) {
  var vm = this;
  vm.email;
  vm.password;
  vm.reqCheckPass = false;
  vm.reqCheckEmail = false;

  vm.lunchConfirm = lunchConfirm;

  function lunchConfirm(event, valid, change, value) {
    if(!valid) {
      if((change === 'password') && !vm.reqCheckPass) {
        vm.reqCheckPass = true;
        return;
      }
      if((change === 'email') && !vm.reqCheckEmail) {
        vm.reqCheckEmail = true;
        return;
      }
      AppShowDialog('Please make sure that the new ' + change + 'is valid!');
      return;
    }
    var dialog = {};
    var locals = {};
    locals.data = {};
    locals.data.type = change;
    locals.data.value = value;
    dialog.templateUrl = 'template-confirm-access';
    dialog.targetEvent = event;
    dialog.clickOutsideToClose = true;
    dialog.controller = 'templateConfirmAccessController';
    dialog.controllerAs = 'vm';
    dialog.locals = locals;
    dialog.bindToController = true;

    $mdDialog.show(dialog);
  }
}

viewSettingsProfileController.controllerName = controllerName;
viewSettingsProfileController.controller = Controller;

export var viewSettingsProfileController = viewSettingsProfileController;
