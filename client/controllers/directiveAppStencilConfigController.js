Controller.$inject = [];

var controllerName = 'directiveAppStencilConfigController';
var directiveAppStencilConfigController = {};

function Controller() {
  var vm = this;
  vm.stencil = {};
  vm.stencil.name = '';
  vm.stencil.type = '';
  vm.stencil.text = {};
  vm.stencil.text.position = '';
  vm.stencil.text.angle = '';
  vm.view = {};
  vm.view.text = [];
  vm.view.stencil = [];
  vm.options = {};
  vm.options.textPosition = textPosition();
  vm.options.textAngle = textAngle();
  vm.changeTextAngle = changeTextAngle;
  vm.changeTextPosition = changeTextPosition;

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
      return [left, right, top, bottom];
    if(position.includes('center '))
      return [left, right];
    if(position.includes(' center'))
      return [top, bottom];
  }

  function changeTextAngle() {
      var newVal = vm.stencil.text.angle;
      var text = vm.view.text;
      text.css('transform', `rotate(${newVal})`);
  }

  function changeTextPosition() {
      var newVal = vm.stencil.text.position;
      var text = vm.view.text;
      vm.options.textAngle = textAngle();
      if(newVal === 'top center') {
        text.css('top', '0%');
        text.css('left', '45%');
        text.css('right', '');
        text.css('bottom', '');
      }
      if(newVal === 'bottom center') {
        text.css('bottom', '0%');
        text.css('left', '43%');
        text.css('right', '0%');
        text.css('top', '');
      }
      if(newVal === 'top right') {
        text.css('top', '0%');
        text.css('right', '3%');
        text.css('left', '');
        text.css('bottom', '');
      }
      if(newVal === 'top left') {
        text.css('top', '0%');
        text.css('left', '0%');
        text.css('right', '');
        text.css('bottom', '');
      }
      if(newVal === 'bottom right') {
        text.css('bottom', '1%');
        text.css('right', '4%');
        text.css('left', '');
        text.css('top', '');
      }
      if(newVal === 'bottom left') {
        text.css('bottom', '0%');
        text.css('left', '0%');
        text.css('right', '');
        text.css('top', '');
      }
      if(newVal === 'center left') {
        text.css('top', '45%');
        text.css('left', '');
        text.css('right', '');
        text.css('bottom', '');
      }
      if(newVal === 'center right') {
        text.css('top', '43%');
        text.css('right', '3%');
        text.css('left', '');
        text.css('bottom', '');
      }
    }
}

directiveAppStencilConfigController.controllerName = controllerName;
directiveAppStencilConfigController.controller = Controller;

export var directiveAppStencilConfigController = directiveAppStencilConfigController;
