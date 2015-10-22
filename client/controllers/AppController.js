import { default as reqLogin } from 'reqLogin'

function Controller() {
  var vm = this;
  vm.date;
}

var controllerName = 'appController',
  url = '/app',
  tmpUrl = 'view-app',
  ctrlAs = 'vm',
  resolve = {},
  config = {},
  appController = {};

resolve.reqLogin = reqLogin;

config.templateUrl = tmpUrl;
config.controller = controllerName;
config.controllerAs = ctrlAs;
config.resolve = resolve;

appController.url = url;
appController.controllerName = controllerName;
appController.config = config;
appController.controller = Controller;

export var appController = appController;
