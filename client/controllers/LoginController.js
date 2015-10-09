Controller.$inject = ['$location'];

function Controller($location) {
  var vm = this;
  vm.email = 'email';
  vm.password = 'password';
  vm.login = login;
  vm.register = register;

  function login() {
    console.log('login');
  }

  function register() {
    $location.path('/register');
  }
}

var moduleName = 'loginController';
var url = '/login';

var config = {
  templateUrl : '/views/view-login.html',
  controller : moduleName,
  controllerAs: 'vm'
};

var loginController = {
  url : url,
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var loginController = loginController;
