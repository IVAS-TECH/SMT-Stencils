Controller.$inject = [];

var controllerName = 'viewOrderController';
var viewOrderController = {};

function Controller() {
    var vm = this;
    vm.step = true;
    vm.change = change;
    function change() {
      vm.step = !vm.step;
    }
 }

viewOrderController.controllerName = controllerName;
viewOrderController.controller = Controller;

export var viewOrderController = viewOrderController;
