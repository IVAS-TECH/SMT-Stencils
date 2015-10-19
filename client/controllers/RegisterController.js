Controller.$inject = ['$location', 'Restangular', '$q'];

function Controller($location, Restangular, $q) {
  var rest = Restangular.all('register');
  var vm = this;
  vm.email = 'email@a.a';
  vm.password = 'password';
  vm.repassword = 'password';
  vm.repasswordBlur = true;
  vm.register = register;
  vm.back = back;
  vm.exist = exist;

  function register() {
    var user = {};
    user.email = vm.email;
    user.password = vm.password;
    rest.post(user);
  }

  function back() {
    $location.path('/login');
  }

  function exist (modelValue, viewValue) {
    var deferred = $q.defer();
    rest.get(modelValue).then(success);

    function success (res) {
      if (res.user)
        deferred.reject();
      else
        deferred.resolve();
    }

    return deferred.promise;
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
