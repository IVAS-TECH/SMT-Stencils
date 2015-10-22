all: clean unset setup mongo

setup: install build

run:
	node ./server/app.js

install:
	bower install
	npm install

build:
	cp ./node_modules/babel-core/browser.js ./client/dependencies/browser.js
	cp ./node_modules/es6-module-loader/dist/es6-module-loader-dev.js  ./client/dependencies/es6-module-loader-dev.js
	cp ./bower_components/angular/angular.js -r ./client/dependencies/
	cp ./bower_components/angular-route/angular-route.js ./client/dependencies/angular-route.js
	cp ./bower_components/angular-cookies/angular-cookies.js ./client/dependencies/angular-cookies.js
	cp ./bower_components/restangular/dist/restangular.js ./client/dependencies/restangular.js
	cp ./bower_components/lodash/lodash.js ./client/dependencies/lodash.js

unset:
	rm -Rf ./client/dependencies
	mkdir -p ./client/dependencies

clean:
	rm -Rf ./bower_components
	rm -Rf ./node_modules

mongo:
	mkdir ./server/data
	mongod --dbpath ./server/data
