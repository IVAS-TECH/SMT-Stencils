class Controller {
  constructor() {
    var vm = this;
    vm.ivo = 'ivo';
  }
}

var moduleName = 'registerController';

var config = {
  templateUrl : '/views/view-register.html',
  controller : moduleName,
  controllerAs : 'vm'
};

var registerController = {
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var registerController = registerController;
