Controller.$inject = ['$mdDialog', 'AppShowDialog'];
//Controller.$inject.push('AppShowDialog');

var controllerName = 'templateConfirmAccessController',
  templateConfirmAccessController = {};

function Controller($mdDialog, AppShowDialog) {
  var vm = this;


  vm.doConfirm = doConfirm;
  function doConfirm(valid) {
    console.log(vm.data);
    $mdDialog.hide("bot");
    if(valid)
      AppShowDialog("Bot");

  }
}

templateConfirmAccessController.controllerName = controllerName;
templateConfirmAccessController.controller = Controller;

export var templateConfirmAccessController = templateConfirmAccessController;
