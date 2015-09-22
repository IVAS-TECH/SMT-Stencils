class Controller {
  constructor() {
    var vm = this;
    vm.data = [3, 2, 1, 4, 5];
  }
}

var moduleName = 'loginController';

var config = {
  templateUrl : '/views/view-login.html',
  controller : moduleName,
  controllerAs: 'vm'
};

var loginController = {
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var loginController = loginController;
