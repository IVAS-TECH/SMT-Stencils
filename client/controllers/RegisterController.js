Controller.$inject = ['$location', 'Restangular'];

function Controller($location, Restangular, $q) {
  var rest = Restangular.all('register');
  var vm = this;
  vm.user = {};
  vm.user.email = 'email@a.a';
  vm.user.password = 'password';
  vm.repassword = 'password';
  vm.repasswordBlur = true;
  vm.register = register;
  vm.back = back;
  vm.exist = exist;

  function register() {
    var user = {};
    user.user = vm.user;
    rest.post(user);
  }

  function back() {
    $location.path('/login');
  }

  function exist (modelValue, viewValue) {
    var promise = new Promise(resolver);

    function resolver (resolve, reject) {
      rest.get(modelValue).then(success);

      function success (res) {
        if (res.user)
          reject();
        else
          resolve();
      }
    }

    return promise;
  }

}

var moduleName = 'registerController';
var url = '/register';

var config = {
  templateUrl : '/views/view-register.html',
  controller : moduleName,
  controllerAs : 'vm'
};

var registerController = {
  url : url,
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var registerController = registerController;
