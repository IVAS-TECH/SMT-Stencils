try
  fse = require "fs-extra"
catch error
  console.log "npm install is required"
  return
fse = require "fs-extra"
{join} = require "path"
{walk} = require "walk"
clientDir = join __dirname, "client"
sendDir = join __dirname, "deploy/send"
deployDir = join __dirname, "deploy"
compileDir = join __dirname, "compile"
nodeModules = "./node_modules"
{spawn, spawnSync} = require "child_process"
Promise = require "promise"

exec =
  jade: "./node_modules/jade/bin/jade.js"
  browserify: "./node_modules/browserify/bin/cmd.js"
  uglifyJS: "./node_modules/uglify-js/bin/uglifyjs"
  karma: "./node_modules/karma-cli/bin/karma"
  mocha: "./node_modules/mocha/bin/mocha"
  _mocha: "./node_modules/mocha/bin/_mocha"
  istanbul: "./node_modules/istanbul/lib/cli.js"
  coffee: "./node_modules/coffee-script/bin/coffee"

task "mongodb", "Setups mongodb on 0.0.0.0:27017/db", ->
  fse.ensureDir join __dirname, "data"
  ip = require "ip"
  address = ip.address()
  args = ["--dbpath", "./data"]#, "--bind_ip", address, "--port", 4000]
  #if ip.isV6Format address then args.push "--ipv6"
  spawn "mongod", args, stdio: "inherit"

task "coffee", "Compiles coffee to js", ->
  spawnSync exec.coffee, ["-c", "-b", "-o", "./compile", "./client"], stdio: "inherit"
  spawnSync exec.coffee, ["-c", "-b", "-o", "./deploy", "./server"], stdio: "inherit"

task "jade", "Compiles jade to html", ->
  spawnSync exec.jade, ["./client", "-o", "./compile"], stdio: "inherit"

task "browserify", "Wraps everything up", ->
  fse.ensureFileSync join sendDir, "bundle.js"
  spawnSync exec.browserify, ["./compile/main.js", "-o", "./deploy/send/bundle.js"], stdio: "inherit"

task "bundle", "Compiles jade and coffee and bundles into single bundle.js file", ->
  invoke "jade"
  walker = walk compileDir
  map = {}
  walker.on "file", (root, file, next) ->
    info = file.name.split "\."
    path = join root, file.name
    if info[0] not in ["index", "error"]
      map[info[0]] = fse.readFileSync path, "utf8"
    else
      dest = join sendDir, file.name
      fse.ensureFileSync dest
      fse.copySync path, dest
    next()
  walker.on "end", ->
    fse.emptyDirSync compileDir
    file = join clientDir, "helper/template.coffee"
    fse.writeFileSync file, "map = #{JSON.stringify map}\nmodule.exports = (tmp) -> map[tmp]"
    invoke "coffee"
    invoke "browserify"
    invoke "style"
    #spawnSync "uglifyjs", ["#{sendDir}/bundle.js", "-o", "#{sendDir}/final.js"], stdio: "inherit"
    style = join sendDir, "style.css"
    bundle = join sendDir, "bundle.js"
    index = join sendDir, "index.html"
    styleContent = fse.readFileSync style, "utf8"
    bundleContent = fse.readFileSync bundle, "utf8"
    indexContent = fse.readFileSync index, "utf8"
    styled = indexContent.replace "@@@", styleContent
    bundled = styled.replace "!!!", JSON.stringify bundleContent
    fse.writeFileSync index, bundled, "utf8"

task "style", "Compiles all Stylus files into single CSS3 file", ->
  console.log "Compiling all Stylus files and @angular-material.css into single CSS3 file..."
  stylus = require "stylus"
  nib = require "nib"
  uglify = require "uglifycss"
  styles = join clientDir, "styles"
  styl = join styles, "styl-style.styl"
  stylContent = fse.readFileSync styl, "utf8"
  material = join __dirname, "node_modules/angular-material/angular-material.min.css"
  materialContent = fse.readFileSync material, "utf8"
  stylus stylContent
    .include styles
    .use nib()
    .render (cssErr, css) ->
      if cssErr then console.log cssErr
      cssFile = join sendDir, "style.css"
      cssContent = "#{materialContent}\n#{css}"
      opts =
        maxLineLen: 0
        expandVars: false
        uglyComments:true
        cuteComments: false
      uglified = uglify.processString cssContent, opts
      fse.ensureFileSync cssFile
      fse.writeFileSync cssFile, uglified, "utf8"
  console.log "Compiling all Stylus files and @angular-material.css into single CSS3 file    done"

task "resources", "Pulls all resource files & Generates default stencil SVG", ->
  GerberToSVG = require "./server/lib/GerberToSVG"
  resources = join __dirname, "client/resources"
  console.log "Pulling resources..."
  fse.removeSync resources
  clone = spawnSync "git", ["clone", "https://github.com/NoHomey/diplomna_resources", resources], stdio: "inherit"
  fse.removeSync join resources, ".git"
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
      fse.writeFileSync top, svg.top, "utf8"
      console.log "Generating default stencil SVG    done"

task "clean", "Returns repo as it was pulled", ->
  client = join __dirname, "client"
  console.log "Restoring repository state..."
  fse.removeSync join __dirname, "node_modules"
  fse.removeSync join client, "resources"
  fse.removeSync join client, "install"
  fse.removeSync join client, "styles/style.css"
  console.log "Restoring repository state    dome"

task "build", "Wraps up the building proccess", ->
  #invoke "clean"
  invoke "resources"
  invoke "bundle"

task "start", "Starts the server and stops it on entering 'stop'", ->
  invoke "bundle" #testing only
  console.log "Starting server..."
  server = spawn "node", ["./deploy/server.js"], stdio: "inherit"
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

task "testing", "Remove all coffee generated code that can't be covered", ->
  invoke "bundle"
  replacement = " || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };"
  replacer = ";"
  fs = require "fs"
  replaceStream = require "replacestream"
  walker = walk __dirname,
    filters: [".git", "node_modules", "coverage"]

  new Promise (resolve) ->
    walker.on "end", resolve
    walker.on "file", (root, file, next) ->
      info = file.name.split "."
      if info.length is 1
        return next()
      if info[1] isnt "js"
        return next()
      path = join root, file.name
      writeStream = fs.createWriteStream path + "x"
      readStream = fs.createReadStream path
      writeStream.on "finish", ->
        fse.removeSync path
        fs.renameSync path + "x", path
        next()
      readStream
        .pipe replaceStream replacement, replacer
        .pipe writeStream

task "angular", "Runs tests and shows coverage results for client side code", ->
  (invoke "testing").then ->
    spawnSync exec.karma, ["start", "client/karma.conf.js"], stdio: "inherit"

mocha = (args) ->
  new Promise (resolve, reject) ->
    walker = walk join __dirname, "server"
    files = []
    walker.on "file", (root, file, next) ->
      if file.name.match "_spec.js"
        files.push join root, file.name
      next()
    walker.on "end", ->
      files.reverse()
      args.push file for file in files
      resolve args

task "express", "Runs tests and shows coverage results for server side code", ->
  (invoke "testing").then ->
    (mocha ["--opts", "./server/mocha.conf"]).then (args) ->
      spawnSync exec.mocha, args, stdio: "inherit"

task "coverage", "It shows code coverage", ->
  open = require "open"
  (invoke "testing").then ->
    spawnSync exec.karma, ["start", "client/karma.conf.js"], stdio: "inherit"
    (mocha ["cover", exec._mocha, "--", "--opts", "./server/mocha.conf"]).then (args) ->
      spawnSync exec.istanbul, args, stdio: "inherit"
      open join __dirname, "client/coverage/html/index.html"
      open join __dirname, "coverage/lcov-report/index.html"
