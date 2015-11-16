Controller.$inject = ['Restangular', '$scope'];

var controllerName = 'directiveAppStencilConfigController';
var directiveAppStencilConfigController = {};

function Controller(Restangular, $scope) {
  var vm = this;
  vm.stencil = {};
  vm.stencil.name = '';
  vm.stencil.type = '';
  vm.stencil.tick = '';
  vm.stencil.fudical = {};
  vm.stencil.fudical.marks = '';
  vm.stencil.fudical.side = '';
  vm.stencil.text = {};
  vm.stencil.text.position = '';
  vm.stencil.text.angle = '';
  vm.stencil.text.side = '';
  vm.stencil.position = {};
  vm.stencil.position.position = '';
  vm.stencil.position.align = '';
  vm.stencil.position.side = '';
  vm.style = {};
  vm.style.text = {};
  vm.style.text.color = 'sque-side';
  vm.style.stencil = {};
  vm.style.stencil.out = false;
  vm.style.stencil.lay = true;
  vm.view = {};
  vm.view.text = [];
  vm.view.stencil = [];
  vm.options = {};
  vm.options.textPosition = textPosition();
  vm.options.textAngle = textAngle();
  vm.textAngle = textAngle
  vm.changeStencilPosition = changeStencilPosition;
  vm.doCreate = doCreate;
  vm.changeText = changeText

  function doCreate(valid) {
    if(valid) {
      var rest = Restangular.all('config');
      var config = {};
      config.config = vm.stencil;
      rest.post(config).then(success);

      function success(res) {
        console.log("res",res);
      }
    }
  }

  function textPosition() {
    var options = [];
    var directionsY = ['top', 'bottom', 'center'];
    var directionsX = ['left', 'right', 'center'];
    for(var i = 0; i < 3; ++i)
      for(var j = 0; j < 3; ++j)
        options.push(directionsY[i] + '-' + directionsX[j]);
    options.pop();
    return options;
  }

  function textAngle() {
    var left = {};
    left.text = 'left';
    left.value = '270deg';
    var right = {};
    right.text = 'right';
    right.value = '90deg';
    var top = {};
    top.text = 'top';
    top.value = '180deg';
    var bottom = {};
    bottom.text = 'bottom';
    bottom.value = '0deg';
    var position = vm.stencil.text.position;
    if(!position.includes('center'))
      return [left, right, bottom, top];
    if(position.includes('center-'))
      return [left, right];
    if(position.includes('-center'))
      return [bottom, top];
  }

  function changeStencilPosition() {
    var newVal = vm.stencil.position.position;
    if(newVal !== 'out') {
      vm.style.stencil.out = false
      vm.style.stencil.lay = newVal === 'lay'
      return;
    }
    else
      vm.style.stencil.lay = false
      vm.style.stencil.out = true
  }

  function changeText(text) {
    var pos = text.position
    var angle = text.angle
    var angles = vm.options.textAngle
    if(!vm.stencil.text.position)
      return "text-top-left-90deg"
    if(!includes(angles, angle))
      return ("text-" + text.position + "-" + angles[0].value)
    return ("text-" + text.position + "-" + text.angle)

    function includes(angls, angl) {
      for(var i = 0;i < angles.length;++i)
        if(angl === angles[i].value)
          return true
      return false
    }
  }
}

directiveAppStencilConfigController.controllerName = controllerName;
directiveAppStencilConfigController.controller = Controller;

export var directiveAppStencilConfigController = directiveAppStencilConfigController;
