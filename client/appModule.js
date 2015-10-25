import { config, controllers } from 'config';
import { directives } from 'appDirectives';
import { services } from 'appServices';

var moduleName = 'app';

angular
  .module(moduleName, ['ngRoute', 'ngMaterial', 'ngMessages', controllers.moduleName, directives.moduleName, services.moduleName])
    .config(config);
    
export var app = moduleName;
