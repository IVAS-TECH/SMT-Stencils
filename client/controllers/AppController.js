Controller.$inject = ['Restangular', '$rootScope']

function Controller(Restangular, $rootScope) {
  var vm = this;
  vm.user = $rootScope.user;
}

var controllerName = 'appController',
  url = '/app',
  tmpUrl = 'view-app',
  ctrlAs = 'vm',
  resolve = {},
  config = {},
  appController = {};


config.templateUrl = tmpUrl;
config.controller = controllerName;
config.controllerAs = ctrlAs;
config.resolve = resolve;

appController.url = url;
appController.controllerName = controllerName;
appController.config = config;
appController.controller = Controller;

export var appController = appController;
