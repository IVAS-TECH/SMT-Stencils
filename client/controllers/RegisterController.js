Controller.$inject = ['$location', 'Restangular'];

function Controller($location, Restangular, $q) {
  var vm = this,
    rest = Restangular.all('register');
  vm.user = {};
  vm.user.email;
  vm.user.password;
  vm.repassword;
  vm.repasswordBlur = true;
  vm.reqCheck = false;
  vm.registered = false;
  vm.failed = false;
  vm.register = register;
  vm.back = back;
  vm.exist = exist;

  function register(invalid) {
    if(!vm.reqCheck)
      vm.reqCheck = true;
    if(!invalid) {
      var user = {};
      user.user = vm.user;
      vm.registered = vm.failed = false;
      rest.post(user).then(success);
    }

    function success(res) {
      if(res.msg === '') {
        vm.registered = true;
        reset();
      }
      else
        vm.failed = true;

      function reset() {
        var reseted = '';
        vm.reqCheck = false;
        vm.user.email = reseted;
        vm.user.password = reseted;
        vm.repassword = reseted;
      }
    }
  }

  function back() {
    $location.path('/login');
  }

  function exist(modelValue, viewValue) {
    var promise = new Promise(resolver);

    function resolver(resolve, reject) {
      rest.get(modelValue).then(success);

      function success(res) {
        if (res.user)
          reject();
        else
          resolve();
      }
    }

    return promise;
  }

}

var controllerName = 'registerController',
  url = '/register',
  tmpUrl = 'view-register',
  ctrlAs = 'vm',
  config = {},
  registerController = {};

config.templateUrl = tmpUrl;
config.controller = controllerName;
config.controllerAs = ctrlAs;

registerController.url = url;
registerController.controllerName = controllerName;
registerController.config = config;
registerController.controller = Controller;

export var registerController = registerController;
