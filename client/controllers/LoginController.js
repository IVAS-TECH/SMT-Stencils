Controller.$inject = ['Restangular', '$location', '$rootScope', '$mdToast'];

function Controller(Restangular, $location, $rootScope, $mdToast) {
    var vm = this,
        restReg = Restangular.all('register');
    vm.register = {};
    vm.register.email;
    vm.register.password;
    vm.repassword;
    vm.reqCheckReg = false;
    vm.registered = false;
    vm.failed = false;
    vm.logout = $rootScope.logout ? true : false;
    vm.exist = exist;
    vm.doRegister = doRegister;
    if(vm.logout)
      showToast();

    function showToast() {
      var toast = $mdToast.simple(),
        pos = 'top right fit';
      toast.content($rootScope.logout);
      toast.action('OK');
      toast.highlightAction(true);
      toast.hideDelay(30000);
      toast.position(pos);
      toast.theme('appTheme');
      $mdToast.show(toast).then(isOk);
      delete $rootScope.logout;

      function isOk(res) {
        if(res === 'ok')
          $mdToast.hide(toast);
      }
    }

    function doRegister(invalid) {
        vm.registered = vm.failed = false;
        if (!vm.reqCheckReg)
            vm.reqCheckReg = true;
        if (!invalid) {
            var register = {};
            register.user = vm.register;
            restReg.post(register).then(success);
        }

        function success(res) {
            if (!res.error) {
                vm.registered = true;
                reset();
            } else
                vm.failed = true;

            function reset() {
                var reseted = '';
                vm.reqCheckReg = false;
                vm.register.email = reseted;
                vm.register.password = reseted;
                vm.repassword = reseted;
            }
        }
    }

    function exist(modelValue) {
        var promise = new Promise(resolver);

        function resolver(resolve, reject) {
            restReg.get(modelValue).then(success);

            function success(res) {
                if (res.exist)
                    reject();
                else
                    resolve();
            }
        }

        return promise;
    }

}

var controllerName = 'loginController',
    url = '/login',
    tmpUrl = 'view-login',
    ctrlAs = 'vm',
    config = {},
    loginController = {};

config.templateUrl = tmpUrl;
config.controller = controllerName;
config.controllerAs = ctrlAs;

loginController.url = url;
loginController.controllerName = controllerName;
loginController.config = config;
loginController.controller = Controller;

export var loginController = loginController;
