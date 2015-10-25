import { appShowToastService } from 'AppShowToastService';

var moduleName = 'services',
  services = {};

services.moduleName = moduleName;

angular
  .module(moduleName, [])
    .factory(appShowToastService.serviceName, appShowToastService.service);

export var services = services;
