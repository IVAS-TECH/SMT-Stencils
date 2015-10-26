import { config, controllers } from 'config';
import { directives } from 'appDirectives';
import { services } from 'appServices';

var moduleName = 'app';

function run($rootScope, $state) {
  $rootScope.go = $state.go;
}

angular
  .module(moduleName, ['ui.router', 'ngMaterial', 'ngMessages', controllers.moduleName, directives.moduleName, services.moduleName])
    .config(config)
    .run(run);

export var app = moduleName;
