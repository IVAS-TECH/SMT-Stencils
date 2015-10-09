import { config, default as controllers } from '/config.js';

var moduleName = 'app';

angular.module(moduleName, ['ngRoute', controllers.moduleName])
  .config(config);

export var app = moduleName;
