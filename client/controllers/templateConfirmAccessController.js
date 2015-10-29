Controller.$inject = ['$mdDialog', 'Restangular'];

var controllerName = 'templateConfirmAccessController',
  templateConfirmAccessController = {};

function Controller($mdDialog, Restangular) {
  var vm = this;
  vm.doConfirm = doConfirm;

  function doConfirm(valid) {
    var rest = Restangular.all('profile');
    rest.post(vm.data).then(success);

    function success(res) {
      console.log(res.success);
    }
  }

}

templateConfirmAccessController.controllerName = controllerName;
templateConfirmAccessController.controller = Controller;

export var templateConfirmAccessController = templateConfirmAccessController;
