import { config, controllers } from '/config.js';
import { directives } from '/app.directives.js';

var moduleName = 'app';

angular.module(moduleName, ['ngRoute', controllers.moduleName, directives.moduleName])
  .config(config);

export var app = moduleName;
