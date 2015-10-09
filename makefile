all: unset setup

setup: install build

run:
	node ./server/app.js

install:
	bower install
	npm install

build:
	cp ./bower_components/angular/angular.js -r ./client/dependencies/
	cp ./bower_components/angular-route/angular-route.js ./client/dependencies/angular-route.js
	cp ./node_modules/babel-core/browser.js ./client/dependencies/browser.js
	cp ./node_modules/es6-module-loader/dist/es6-module-loader-dev.js  ./client/dependencies/es6-module-loader-dev.js
	cp ./bower_components/angular-cookies/angular-cookies.js ./client/dependencies/angular-cookies.js

unset:
	rm -R ./client/dependencies/*

clean:
	rm -R ./bower_components
	rm -R ./node_modules
