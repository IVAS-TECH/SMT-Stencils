# diplomna3

# setup

install mongodb

install node and npm

run npm install -g coffee-script

run npm install -g jade

run npm install -g browserify

run npm install -g uglify-js

run mkdir ./server/data && mongod --dbpath ./server/data

run cake build to build the project

if nodegit thows error when installed ensure that libssl-dev is installed and try again.   
if it still fails ensure that libgit2, libssl & libgcrypt that are also installed.   
if it fails again try two more times runnign cake build if it still fails run cake git

run cake start to start the server enter "stop" to stop it
