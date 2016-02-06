gulp = ./node_modules/.bin/gulp

setup:
	sudo apt-get install -y curl
	curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
	sudo apt-get install -y nodejs
	sudo apt-get install -y mongodb
	sudo apt-get install gerbv

build:
	${gulp} --color --require coffee-script/register build

styles:
	${gulp} --color --require coffee-script/register styles
