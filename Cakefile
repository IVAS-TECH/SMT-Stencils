{join} = require "path" ? null
fs = require "fs-extra" ? null
walk = require "walk" ? null
server = null

task "dependencies", "Builds all package dependencies", ->
  {spawnSync} = require "child_process"
  console.log "Installing node packages..."
  spawnSync "npm", ["install"]
  console.log "Installing node packages    done"
  console.log "Installing bower packages..."
  spawnSync "bower", ["install"]
  console.log "Installing bower packages    done"
  {join} = require "path"
  fs = require "fs-extra"
  walk = require "walk"
  transpiler = join __dirname, "/node_modules/babel-core/browser.js" #remove it tommorow
  dependenciesDir = join __dirname, "/client/dependencies"
  material = join __dirname, "bower_components/angular-material/angular-material.css"
  dependencies = [
      "/bower_components/jquery/dist/jquery.js"
      "/bower_components/lodash/lodash.js"
      "/bower_components/angular/angular.js"
      "/bower_components/angular-ui-router/release/angular-ui-router.js"
      "/bower_components/ui-router-extras/release/ct-ui-router-extras.js"
      "/bower_components/angular-ui-router.stateHelper/statehelper.js"
      "/bower_components/angular-aria/angular-aria.js"
      "/bower_components/angular-animate/angular-animate.js"
      "/bower_components/angular-messages/angular-messages.js"
      "/bower_components/angular-material/angular-material.js"
      "/bower_components/restangular/dist/restangular.js"
      "/node_modules/es6-module-loader/dist/es6-module-loader-dev.js"
      "/bower_components/ng-file-upload/ng-file-upload.min.js"
  ]
  concatFiles = (files, out) ->
    result = ""
    concat = (single) ->
      pathToFile = join __dirname, single
      fs.readFileSync pathToFile, "utf8"
    result += concat file for file in files
    fs.writeFileSync out, result, "utf8"
  console.log "Creating/Clearing dependencies Dir..."
  fs.emptyDirSync dependenciesDir
  console.log "Creating/Clearing dependencies Dir    done"
  console.log "Coping <angular-material.css> to <dependencies/>..."
  fs.copySync material, join dependenciesDir, "angular-material.css"
  console.log "Coping <angular-material.css> to <dependencies/>    done"
  fs.copySync transpiler, join dependenciesDir, "browser.js" #also needs to be remove it
  console.log "Building dependencies.js..." # repalce with compiling coffee to single file
  concatFiles dependencies, join dependenciesDir, "dependencies.js"
  console.log "Building dependencies.js done" #remove it
  console.log "Removing ./bower_components..."
  fs.removeSync join __dirname,  "bower_components"
  console.log "Removing ./bower_components    done"

task "style", "Compiles all Stylus files into single CSS3 file", ->
  if not join? then invoke "dependencies"
  console.log "Compiling all Stylus files into single CSS3 file..."
  stylus = require "stylus"
  nib = require "nib"
  styles = join __dirname, "client/styles"
  styl = join styles, "styl-style.styl"
  stylContent = fs.readFileSync styl, "utf8"
  stylus stylContent
    .include styles
    .use nib()
    .render (cssErr, css) ->
      if cssErr then console.log cssErr
      fs.writeFileSync (join styles, "style.css"), css, "utf8"
  console.log "Compiling all Stylus files into single CSS3 file    done"

task "stencil", "Generates default stencil SVG", ->
  if not join? then invoke "dependencies"
  gerbersToSvgLayers = require "./server/gerbersToSvgLayers"
  console.log "Generating default stencil SVG..."
  files = []
  walker = walk.walk join __dirname, "client/resources/samples"
  walker.on "file", (root, file, next) ->
    pathToFile = join root, file.name
    content = fs.readFileSync pathToFile, "utf8"
    files.push {content : content, path : pathToFile}
    next()
  walker.on "end", ->
    svgs = gerbersToSvgLayers files
    top = join __dirname, "client/resources/top.svg"
    fs.writeFileSync top, svgs.top, "utf8"
  console.log "Generating default stencil SVG    done"

task "build", "Wraps up the building proccess", ->
  invoke "dependencies"
  invoke "style"
  invoke "stencil"

task "start", "Starts the server and stops it on entering 'stop'", ->
  console.log "Starting server..."
  {spawn} = require "child_process"
  server = spawn "node", ["server/app.js"], {stdio : "pipe"}
  server.on "exit", (code, signal) ->
    console.log "Stoping server    done"
    console.log "Goodbye :)"
    process.exit 0
  console.log "Starting server    done"
  server.stdout.setEncoding 'utf8'
  process.stdin.setEncoding 'utf8'
  server.stdout.on 'data', (data) -> console.log data
  process.stdin.on "data", (data) ->
    if data.includes "stop"
      server.kill "SIGINT"
      console.log()
      console.log "Stoping server..."
