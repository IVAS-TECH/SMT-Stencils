import { default as reqLogin } from '/controllers/reqLogin.js'

function Controller() {
  var vm = this;
  vm.date;
}

var moduleName = 'appController';
var url = '/';

var resolve = {
  'reqLogin' : reqLogin
};

var config = {
  templateUrl : '/views/view-app.html',
  controller : moduleName,
  controllerAs : 'vm',
  resolve : resolve
};

var appController = {
  url : url,
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var appController = appController;
