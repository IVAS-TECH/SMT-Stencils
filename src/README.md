# diplomna3

# install: [node] and [npm]

Almost all [node] installs include and [npm]

You can install node from it's official page:

https://nodejs.org/en/download/

Or if you are running Linux distribution and it's include here:

https://github.com/nodesource/distributions

you can install it from there.

# setup

Server can currently be ran under Linux only because of [gerbv] beeing a dependency.

if you are using Debian based Linux dist that uses [apt-get]

you can setup the project by runing: [sudo npm run apt-get]

else do:

install: [mongodb]

install: [gerbv] and make sure that it's build with Cairo!

# install dependencies

run: [npm install]

# build

run: [npm run build]

# starting server locally

run: [npm run local] to start the server

navigate to: [ http://localhost:8080 ]

# previewing statistics

run [npm run fillDB]

navigate to: [ http://localhost:8080 ]

# testing

## testing Server only

run: [npm run test-server] to run all server tests and see coverage results for tested files

# deploying at Google Cloud App Engine

install: [gcloud]

run: [gcloud init]

run: [gcloud config set app/cloud_build_timeout 5000]

follow: [ https://cloud.google.com/nodejs/getting-started/deploy-mongodb#run_mongodb_on_google_compute_engine ]

change: [./server/mongo.coffee :: docker:]

run: [gcloud preview app deploy]
