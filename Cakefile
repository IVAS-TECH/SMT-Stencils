fs = null
path = null
join = null
walk = null

task "install", "Installs all required packages", () ->
  process = require "child_process"
  spawn = process.spawnSync
  console.log "Installing node packages..."
  spawn "npm", ["install"]
  console.log "Installing node packages    done"
  console.log "Installing bower packages..."
  spawn "bower", ["install"]
  console.log "Installing bower packages    done"
  fs = require "fs-extra"
  path = require "path"
  join = path.join
  walk = require "walk"

task "style", "Compiles all Stylus files into single CSS3 file", () ->
  console.log "Compiling all Stylus files into single CSS3 file..."
  stylus = require "stylus"
  nib = require "nib"
  styles = join __dirname, "client/styles"
  styl = join styles, "styl-style.styl"
  stylContent = fs.readFileSync styl, "utf8"
  compiler = stylus stylContent
  compiler.include styles
  compiler.use nib()
  compiler.render (cssErr, css) ->
    if cssErr then console.log cssErr
    fs.writeFileSync (join styles, "style.css"), css, "utf8"
    return
  console.log "Compiling all Stylus files into single CSS3 file    done"

task "dependencies", "Builds all Client app dependencies", () ->
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
    fs.createFileSync out
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

task "stencil", "Generates default stencil SVG", () ->
  gerbersToSvgLayers = require "./server/gerbersToSvgLayers"
  console.log "Generating default stencil SVG..."
  files = []
  walker = walk.walk join __dirname, "client/resources/samples"
  addToGerberStack = (root, file, next) ->
    pathToFile = join root, file.name
    content = fs.readFileSync pathToFile, "utf8"
    files.push {content : content, path : pathToFile}
    next()
  generateSvg = () ->
    svgs = gerbersToSvgLayers files
    top = join __dirname, "client/resources/top.svg"
    fs.writeFileSync top, svgs.top, "utf8"
  walker.on "file", addToGerberStack
  walker.on "end", generateSvg
  console.log "Generating default stencil SVG    done"

task "build", "Wraps up th building proccess", () ->
  invoke "install"
  invoke "style"
  invoke "dependencies"
  invoke "stencil"
