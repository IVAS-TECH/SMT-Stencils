all: clean install build

install:
	bower install
	npm install

build:
	mkdir ./app/dependencies
	cp ./bower_components/angular/angular.js -r ./app/dependencies/
	cp ./bower_components/angular-route/angular-route.js ./app/dependencies/angular-route.js
	cp ./node_modules/babel-core/browser.js ./app/dependencies/browser.js
	cp ./node_modules/es6-module-loader/dist/es6-module-loader-dev.js  ./app/dependencies/es6-module-loader-dev.js

clean:
	rm -R ./app/dependencies
	rm -R ./bower_components
	rm -R ./node_modules
