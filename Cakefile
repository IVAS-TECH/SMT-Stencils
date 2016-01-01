{join} = require "path"
walk = null
try
  fs = require "fs-extra"
catch error
  fs = null
if fs?
  {walk} = require "walk"
clientDir = join __dirname, "./client"
appDir = join clientDir, "app"
{spawn, spawnSync} = require "child_process"

task "install", "Builds all package install", ->
  console.log "Installing node packages... (Please wait this will take some time)"
  spawnSync "npm", ["install"], stdio: "inherit"
  console.log "Installing node packages    done"
  fs = require "fs-extra"
  {walk} = require "walk"

task "mongodb", "Setups mongodb on 0.0.0.0:27017/db", ->
  if not fs then invoke "install"
  fs.ensureDir join __dirname, "data"
  ip = require "ip"
  address = ip.address()
  args = ["--dbpath", "./data"]#, "--bind_ip", address, "--port", 4000]
  #if ip.isV6Format address then args.push "--ipv6"
  spawn "mongod", args, stdio: "inherit"

task "coffee", "Compiles coffee to js", ->
  spawnSync "coffee", ["-c", "-b", "./client"], stdio: "inherit"
  spawnSync "coffee", ["-c", "-b", "server"], stdio: "inherit"

task "bundle", "Compiles jade and coffee and bundles into single bundle.js file", ->
  invoke "coffee"
  invoke "style"
  spawnSync "jade", ["./client"], stdio: "inherit"
  walker = walk clientDir
  map = {}
  walker.on "file", (root, file, next) ->
    info = file.name.split "."
    if info[1] is "html" and info[0] not in ["index", "error"]
      path = join root, file.name
      map[info[0]] = fs.readFileSync path, "utf8"
    next()
  walker.on "end", ->
    file = join clientDir, "helper/template.coffee"
    fs.writeFileSync file, "map = #{JSON.stringify map}\nmodule.exports = (tmp) -> map[tmp]"
    spawnSync "browserify", ["#{clientDir}/main.js", "-o", "#{appDir}/final.js"], stdio: "inherit"
    #spawnSync "uglifyjs", ["#{appDir}/bundle.js", "-o", "#{appDir}/final.js"], stdio: "inherit"
    style = join appDir, "style.css"
    bundle = join appDir, "final.js"
    index = join appDir, "index.html"
    styleContent = fs.readFileSync style, "utf8"
    bundleContent = fs.readFileSync bundle, "utf8"
    indexContent = fs.readFileSync index, "utf8"
    styled = indexContent.replace "@@@", styleContent
    bundled = styled.replace "!!!", JSON.stringify bundleContent
    fs.writeFileSync index, bundled, "utf8"

task "style", "Compiles all Stylus files into single CSS3 file", ->
  if not fs then invoke "install"
  console.log "Compiling all Stylus files and @angular-material.css into single CSS3 file..."
  stylus = require "stylus"
  nib = require "nib"
  uglify = require "uglifycss"
  styles = join clientDir, "styles"
  styl = join styles, "styl-style.styl"
  stylContent = fs.readFileSync styl, "utf8"
  material = join __dirname, "node_modules/angular-material/angular-material.min.css"
  materialContent = fs.readFileSync material, "utf8"
  stylus stylContent
    .include styles
    .use nib()
    .render (cssErr, css) ->
      if cssErr then console.log cssErr
      cssFile = join appDir, "style.css"
      cssContent = "#{materialContent}\n#{css}"
      uglified = uglify.processString cssContent, maxLineLen: 0, expandVars: false, uglyComments:true, cuteComments: false
      fs.ensureFileSync cssFile
      fs.writeFileSync cssFile, uglified, "utf8"
  console.log "Compiling all Stylus files and @angular-material.css into single CSS3 file    done"

task "resources", "Pulls all resource files & Generates default stencil SVG", ->
  if not fs then invoke "install"
  GerberToSVG = require "./server/lib/GerberToSVG"
  resources = join __dirname, "client/resources"
  console.log "Pulling resources..."
  fs.removeSync resources
  clone = spawnSync "git", ["clone", "https://github.com/NoHomey/diplomna_resources", resources], stdio: "inherit"
  fs.removeSync join resources, ".git"
  console.log "Pulling resources    done"
  console.log "Generating default stencil SVG..."
  files = []
  walker = walk join resources, "samples"
  walker.on "file", (root, file, next) ->
    files.push join root, file.name
    next()
  walker.on "end", ->
    GerberToSVG(files).then (svg) ->
      top = join resources, "top.html"
      fs.writeFileSync top, svg.top, "utf8"
      console.log "Generating default stencil SVG    done"

task "clean", "Returns repo as it was pulled", ->
  if not fs then invoke "install"
  client = join __dirname, "client"
  console.log "Restoring repository state..."
  fs.removeSync join __dirname, "node_modules"
  fs.removeSync join client, "resources"
  fs.removeSync join client, "install"
  fs.removeSync join client, "styles/style.css"
  console.log "Restoring repository state    dome"

task "build", "Wraps up the building proccess", ->
  #invoke "clean"
  invoke "install"
  invoke "resources"
  invoke "bundle"

task "start", "Starts the server and stops it on entering 'stop'", ->
  invoke "bundle" #testing only
  console.log "Starting server..."
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

task "angular", "Runs tests and shows coverage results for client side code", ->
  if not fs then invoke "install"
  invoke "bundle"
  open = require "open"
  spawnSync "karma", ["start", "client/karma.conf.js"], stdio: "inherit"
  open join __dirname, "client/coverage/html/index.html"


task "express", "Runs tests and shows coverage results for server side code", ->
  if not fs then invoke "install"
  invoke "bundle"
  open = require "open"
  walker = walk join __dirname, "server"
  files = []
  walker.on "file", (root, file, next) ->
    if file.name.match "_spec.js"
      files.push join root, file.name
    next()
  walker.on "end", ->
    spawnSync "mocha", ["--opts", "./server/mocha.conf", files.join " "], stdio: "inherit"
    open join __dirname, "server/coverage/html/index.html"
