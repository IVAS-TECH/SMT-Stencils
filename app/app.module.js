import { config, default as controllers } from '/config.js';
import { run } from '/run.js';

var moduleName = 'app';

angular.module(moduleName, ['ngRoute', controllers.moduleName])
  .config(config)
  .run(run);

export var app = moduleName;
