Controller.$inject = [];

var controllerName = 'directiveAppStencilConfigController',
  directiveAppStencilConfigController = {};

function Controller() {
  var vm = this;
  vm.stencil = {};
  vm.stencil.name;
  vm.stencil.type;
  vm.options = {};
  vm.options.textPosition = textPosition();

  function textPosition() {
    var options = [];
    var directionsY = ['top', 'bottom', 'center'];
    var directionsX = ['left', 'right', 'center'];
    for(var i = 0; i < 3; ++i)
      for(var j = 0; j < 3; ++j)
        options.push(directionsY[i] + ' ' + directionsX[j]);
    options.pop();
    return options;
  }
}

directiveAppStencilConfigController.controllerName = controllerName;
directiveAppStencilConfigController.controller = Controller;

export var directiveAppStencilConfigController = directiveAppStencilConfigController;
