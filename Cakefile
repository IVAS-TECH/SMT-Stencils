{join} = require "path"
fs = require "fs-extra" ? null
clientDir = join __dirname, "./client"

task "dependencies", "Builds all package dependencies", ->
  {spawnSync} = require "child_process"
  console.log "Installing node packages... (Please wait this can take more than 5 mins)"
  spawnSync "npm", ["install"], stdio: "inherit"
  ###console.log "Installing node packages    done"
  console.log "Installing bower packages..."
  spawnSync "bower", ["install"]
  console.log "Installing bower packages    done"
  fs = require "fs-extra"
  material = join __dirname, "bower_components/angular-material/angular-material.css"
  dependencies = [
      "/bower_components/ui-router-extras/release/ct-ui-router-extras.js"
      "/bower_components/angular-ui-router.stateHelper/statehelper.js"
  ]
  concatFiles = (files, out) ->
    result = ""
    concat = (single) ->
      pathToFile = join __dirname, single
      fs.readFileSync pathToFile, "utf8"
    result += concat file for file in files
    fs.writeFileSync out, result, "utf8"
  console.log "Coping <angular-material.css> to client"
  fs.copySync material, join dependenciesDir, "angular-material.css"
  console.log "Coping <angular-material.css> to to client    done"
  console.log "Building dependencies.js..."
  concatFiles dependencies, join clientDir, "dependencies.js"
  console.log "Building dependencies.js done"
  console.log "Removing ./bower_components..."
  fs.removeSync join __dirname,  "bower_components"
  console.log "Removing ./bower_components    done" ###

task "bundle", "Compiles jade and coffee and bundles into single bundle.js file", ->
  if not fs then invoke "dependencies"
  {spawnSync} = require "child_process"
  spawnSync "jade", ["./client"], stdio: "inherit"
  {walk} = require "walk"
  {join} = require "path"
  fs = require "fs"
  client = join __dirname, "./client"
  walker = walk client
  map = {}
  walker.on "file", (root, file, next) ->
    info = file.name.split "."
    if info[1] is "html" and info[0] not in ["index", "error"]
      path = join root, file.name
      map[info[0]] = fs.readFileSync path, "utf8"
    next()
  walker.on "end", ->
    file = join client, "template.coffee"
    fs.writeFileSync file, "map = #{JSON.stringify map}\nmodule.exports = (tmp) -> map[tmp]"
    spawnSync "coffee", ["-c", "-b", "./client"], stdio: "inherit"
    spawnSync "browserify", ["./client/main.js", "-o", "./client/bundle.js"]

task "style", "Compiles all Stylus files into single CSS3 file", ->
  if not fs then invoke "dependencies"
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
      cssFile = join styles, "style.css"
      fs.writeFileSync cssFile, css, "utf8"
  console.log "Compiling all Stylus files into single CSS3 file    done"

task "resources", "Pulls all resource files & Generates default stencil SVG", ->
  if not fs then invoke "dependencies"
  {walk} = require "walk"
  gerbersToSvgLayers = require "./server/lib/gerbersToSvgLayers"
  {Clone} = require "nodegit"
  resources = join __dirname, "client/resources"
  console.log "Pulling resources..."
  fs.removeSync resources
  clone = Clone.clone "https://github.com/NoHomey/diplomna_resources", resources
  clone.then (repo) ->
    fs.removeSync join resources, ".git"
    console.log "Pulling resources    done"
    console.log "Generating default stencil SVG..."
    files = []
    walker = walk join resources, "samples"
    walker.on "file", (root, file, next) ->
      pathToFile = join root, file.name
      content = fs.readFileSync pathToFile, "utf8"
      files.push content: content, path: pathToFile
      next()
    walker.on "end", ->
      svgs = gerbersToSvgLayers files
      top = join resources, "top.svg"
      fs.writeFileSync top, svgs.top, "utf8"
    console.log "Generating default stencil SVG    done"

task "clean", "Returns repo as it was pulled", ->
  if not fs then invoke "dependencies"
  client = join __dirname, "client"
  console.log "Restoring repository state..."
  fs.removeSync join __dirname, "node_modules"
  fs.removeSync join client, "resources"
  fs.removeSync join client, "dependencies"
  fs.removeSync join client, "styles/style.css"
  console.log "Restoring repository state    dome"

task "build", "Wraps up the building proccess", ->
  invoke "clean"
  invoke "dependencies"
  invoke "style"
  invoke "resources"

task "start", "Starts the server and stops it on entering 'stop'", ->
  console.log "Starting server..."
  {spawn, spawnSync} = require "child_process"
  spawnSync "coffee", ["-c", "-b", "server"], stdio: "inherit"
  server = spawn "node", ["server/server.js"], stdio: "inherit"
  console.log "Starting server    done"
  process.stdin.setEncoding 'utf8'
  server.on "exit", (code, signal) ->
    console.log "Stoping server    done"
    console.log "Goodbye :)"
    process.exit 0
  process.stdin.on "data", (data) ->
    if data.includes "stop"
      server.kill "SIGINT"
      console.log()
      console.log "Stoping server..."
