function Controller() {
  var vm = this;
  vm.date;
}

var moduleName = 'appController';

var config = {
  templateUrl : '/views/view-app.html',
  controller : moduleName,
  controllerAs : 'vm'
};

var appController = {
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var appController = appController;
