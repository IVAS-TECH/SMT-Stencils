# diplomna3

# setup

if you are using Debian based Linux dist that uses apt-get

you can setup the project by runing: sudo make setup.

install: mongodb

install: node and npm

run: npm install -g coffee-script

run: npm install -g jade

run: npm install -g browserify

run: npm install -g uglify-js

run: mkdir ./server/data && mongod --dbpath ./server/data

# build

run: cake build to build the project

# start/stop server

run: cake start to start the server enter "stop" to stop it
