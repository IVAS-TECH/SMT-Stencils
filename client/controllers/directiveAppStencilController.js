var controllerName = 'directiveAppStencilController';
var directiveAppStencilController = {};

function Controller () {
  var stencil = this;
  stencil.previewElement = {};
  stencil.previewElement.text;
  stencil.previewElement.body;
  stencil.previewElement.img;
}

directiveAppStencilController.controller = Controller;
directiveAppStencilController.controllerName = controllerName;

export var directiveAppStencilController = directiveAppStencilController;
