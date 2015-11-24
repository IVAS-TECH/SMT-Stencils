{join} = require "path"
{walk} = require "walk" ? null
fs = require "fs-extra" ? null
clientDir = join __dirname, "./client"
appDir = join clientDir, "app"

task "install", "Builds all package install", ->
  {spawnSync} = require "child_process"
  console.log "Installing node packages... (Please wait this can take more than 5 mins)"
  spawnSync "npm", ["install"], stdio: "inherit"
  console.log "Installing node packages    done"
  fs = require "fs-extra"
  {walk} = require "walk"

task "bundle", "Compiles jade and coffee and bundles into single bundle.js file", ->
  invoke "style"
  {spawnSync} = require "child_process"
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
    spawnSync "coffee", ["-c", "-b", "./client"], stdio: "inherit"
    spawnSync "browserify", ["#{clientDir}/main.js", "-o", "#{appDir}/bundle.js"], stdio: "inherit"
    #spawnSync "uglifyjs", ["#{appDir}/bundle.js", "-o", "#{appDir}/final.js"]
    style = join appDir, "style.css"
    bundle = join appDir, "bundle.js"
    index = join appDir, "index.html"
    styleContent = fs.readFileSync style, "utf8"
    bundleContent = fs.readFileSync bundle, "utf8"
    indexContent = fs.readFileSync index, "utf8"
    styled = indexContent.replace "@@@", styleContent
    bundled = styled.replace "!!!", bundleContent
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
