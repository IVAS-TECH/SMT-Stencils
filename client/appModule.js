import { config } from 'config';
import { run } from 'run';
import { appDirectives } from 'appDirectives';
import { appServices } from 'appServices'

var moduleName = 'app';

angular
  .module(moduleName, ['restangular', 'ui.router', 'ngMaterial', 'ngMessages', appDirectives.moduleName, appServices.moduleName])
    .config(config)
    .run(run);

export var app = moduleName;
