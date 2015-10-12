Controller.$inject = ['$location', 'Restangular'];

function Controller($location, Restangular) {
  var rest = Restangular.all('register');
  var vm = this;
  vm.email = 'email@a.a';
  vm.password = 'password';
  vm.repassword = 'password';
  vm.repasswordBlur = true;
  vm.register = register;
  vm.back = back;
  vm.res = "res";

  function register() {
    vm.res = rest.get(vm.email);//.then(function(r) {console.log(r);});
  }

  function back() {
    $location.path('/login');
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
