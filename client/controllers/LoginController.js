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
