class Controller {
  constructor() {
    var vm = this;
    vm.data = [3, 2, 1, 4, 5];
    vm.ivo = 'ivo';
  }
}

var moduleName = 'statsController';

var config = {
  templateUrl : '/views/view-stats.html',
  controller : moduleName,
  controllerAs : 'vm'
};

var statsController = {
  moduleName : moduleName,
  config : config,
  controller : Controller
};

export var statsController = statsController;
