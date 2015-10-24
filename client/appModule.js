import { config, controllers } from 'config';
import { directives } from 'appDirectives';

var moduleName = 'app';

angular
  .module(moduleName, ['ngRoute', 'ngMaterial', 'ngMessages', controllers.moduleName, directives.moduleName])
    .config(config);

export var app = moduleName;
