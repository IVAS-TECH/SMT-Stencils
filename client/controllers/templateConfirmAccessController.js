Controller.$inject = ['$mdDialog', '$rootScope', 'Restangular'];

var controllerName = 'templateConfirmAccessController',
  templateConfirmAccessController = {};

function Controller($mdDialog, $rootScope, Restangular) {
  var vm = this;
  vm.password;
  vm.repassword;
  vm.error = false;
  vm.success = false;
  vm.reqCheck = false;
  vm.msg = '';
  vm.close = close;
  vm.tryAgain = tryAgain;
  vm.doConfirm = doConfirm;

  function doConfirm(valid) {
    if(!vm.reqCheck && !valid) {
      vm.reqCheck = true;
      return;
    }
    if(valid) {
      if(vm.password !== $rootScope.user.password) {
        vm.error = true;
        return;
      }

      var rest = Restangular.all('profile');
      rest.post(vm.data).then(success);

      function success(res) {
        if(res.success) {
          vm.success = true;
          vm.msg = "You have successfully changed your " + vm.data.type;
        }
      }
    }
    else
      vm.error = true;
  }

  function close() {
    $mdDialog.hide();
  }

  function tryAgain() {
    vm.error = false;
    vm.reqCheck = false;
    vm.password = '';
    vm.repassword = '';
  }
}

templateConfirmAccessController.controllerName = controllerName;
templateConfirmAccessController.controller = Controller;

export var templateConfirmAccessController = templateConfirmAccessController;
