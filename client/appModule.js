import { config } from 'config';
import { run } from 'run';
import { appDirectives } from 'appDirectives';
import { appServices } from 'appServices';

var moduleName = 'app',
  dependencies = [
    'ui.router.stateHelper',
    'ct.ui.router.extras',
    'restangular',
    'ui.router',
    'ngMaterial',
    'ngMessages',
    appDirectives.moduleName,
    appServices.moduleName
  ];

angular
  .module(moduleName, dependencies)
    .config(config)
    .run(run);

export var app = moduleName;
