import { default as reqLogin } from 'reqLogin'

function Controller() {
  var vm = this;
  vm.date;
}

var controllerName = 'settingsController',
  url = '/settings',
  tmpUrl = 'view-settings',
  ctrlAs = 'vm',
  resolve = {},
  config = {},
  settingsController = {};

resolve.reqLogin = reqLogin;

config.templateUrl = tmpUrl;
config.controller = controllerName;
config.controllerAs = ctrlAs;
config.resolve = resolve;

settingsController.url = url;
settingsController.controllerName = controllerName;
settingsController.config = config;
settingsController.controller = Controller;

export var settingsController = settingsController;
