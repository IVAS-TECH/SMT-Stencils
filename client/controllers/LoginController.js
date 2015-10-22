Controller.$inject = ['Restangular', '$location'];

function Controller(Restangular, $location) {
  var vm = this,
    restReg = Restangular.all('register');
  vm.register = {};
  vm.register.email;
  vm.register.password;
  vm.login = {};
  vm.login.email;
  vm.login.password;
  vm.repassword;
  vm.repasswordBlur = true;
  vm.reqCheckReg = false;
  vm.reqCheckLogin = false;
  vm.registered = false;
  vm.failed = false;
  vm.exist = exist;
  vm.doRegister = doRegister;
  vm.doLogin = doLogin;

  function doRegister(invalid) {
    vm.registered = vm.failed = false;
    if(!vm.reqCheckReg)
      vm.reqCheckReg = true;
    if(!invalid) {
      var register = {};
      register.user = vm.register;
      restReg.post(register).then(success);
    }

    function success(res) {
      if(!res.error) {
        vm.registered = true;
        reset();
      }
      else
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

  function doLogin(invalid) {
    if(!vm.reqCheckLogin)
      vm.reqCheckLogin = true;
    if(!invalid) {
      var login = {},
        restLogin = Restangular.all('login');
      login.user = vm.login;
      restLogin.post(login).then(success);
    }

    function success(res) {
      if(res.success)
        $location.path('/app');
      else
        vm.failed = true;
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
