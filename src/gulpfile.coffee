fs = require "fs"
del = require "del"
nib = require "nib"
gulp = require "gulp"
gzip = require "gulp-gzip"
jade = require "gulp-jade"
gutil = require "gulp-util"
vinyl = require "vinyl-paths"
coffee = require "gulp-coffee"
stylus = require "gulp-stylus"
css = require "gulp-uglifycss"
open = require "open"
inline = require "gulp-inline"
concat = require "gulp-concat"
uglify = require "gulp-uglify"
browserify = require "browserify"
templateCache = require "gulp-angular-templatecache"
{spawnSync} = require "child_process"

gulp.task "apt-get", -> spawnSync "sudo", ["apt-get", "install", "-y", "mongodb", "gerbv"]

gulp.task "clean", -> del.sync ["./templates", "./build", "./resources"]

gulp.task "clear", ["clean"], -> del.sync ["./deploy"]

gulp.task "jade", ["clear"], ->
  gulp.src "./client/**/*.jade"
    .pipe jade jade: require "jade"
    .on "error", gutil.log
    .pipe gulp.dest "./templates"

gulp.task "index", ["jade"], ->
  gulp.src "./templates/index.html"
    .pipe vinyl del
    .pipe gulp.dest "./build/inline"

gulp.task "cache", ["index"], ->
  gulp.src "./templates/**/*.html"
    .pipe vinyl del
    .pipe templateCache "templates.js",
      moduleSystem: "Browserify"
      standalone: yes
      transformUrl: (url) ->
        struc = (url.split ".")[0].split "/"
        struc[struc.length - 1]
    .pipe gulp.dest "./build"

gulp.task "client", ["cache"], ->
  gulp.src "./client/**/*.coffee"
    .pipe coffee bare: yes
    .on "error", gutil.log
    .pipe gulp.dest "./build"

gulp.task "server", ["client"], ->
  gulp.src "./server/**/*.coffee"
    .pipe coffee bare: yes
    .on "error", gutil.log
    .pipe gulp.dest "./deploy"

gulp.task "browserify", ["server"], ->
  stream = fs.createWriteStream "./build/bundle.js"
  (browserify "./build/main.js").bundle (err, bundle) ->
    stream.write bundle.toString(), "utf8", (err) ->
      if err then gutil.log err else stream.end()
  stream

gulp.task "uglify", ["browserify"], ->
  gulp.src "./build/bundle.js"
    .pipe gzip append: no
    .pipe gulp.dest "./deploy/send"

gulp.task "stylus", ["uglify"], ->
  gulp.src "./client/styles/style.styl"
    .pipe stylus
      compress: yes
      use: nib()
    .pipe gulp.dest "./build"

gulp.task "styles", ["stylus"], ->
  gulp.src [
      "./build/style.css"
      "./node_modules/angular-material/angular-material.min.css"
      "./node_modules/angular-chart.js/dist/angular-chart.min.css"
    ]
    .pipe concat "style.css"
    .pipe gzip append: no
    .pipe gulp.dest "./deploy/send"

gulp.task "bundle", ["styles"], ->
  gulp.src "./build/inline/index.html"
    .pipe gzip append: no
    .pipe gulp.dest "./deploy/send"

gulp.task "clone", ["bundle"], ->
  spawnSync "git", [
    "clone"
    "https://github.com/IVAS-TECH/SMT-Stencils_resources.git"
    "./resources"
  ], stdio: "ignore"

gulp.task "preview", ["clone"], ->
  gulp.src "./resources/top.html"
    .pipe gzip append: no
    .pipe gulp.dest "./deploy/send/api/template"

gulp.task "favicon", ["preview"], ->
  gulp.src "./resources/favicon.ico"
    .pipe gzip append: no
    .pipe gulp.dest "./deploy/send"

gulp.task "folders", ["favicon"], ->
    spawnSync "cp", ["-R", "./descriptionTemplates", "./deploy"]
    spawnSync "mkdir", ["./deploy/logs"]
    spawnSync "mkdir", ["./deploy/files"]
    spawnSync "mkdir", ["./deploy/files/tmp"]

gulp.task "build", ["folders"]

gulp.task "mocha", [], ->
    tests = ["", "lib", "lib/session", "share", "routes", "routes/user/visit", "routes/user", "routes/order/notification", "routes/order/description", "routes/order", "routes/order/file"]
    mocha = ["--opts", "./server/mocha.conf"]
    mocha.push "./server/" + dir + "/test" for dir in tests
    spawnSync "./node_modules/.bin/mocha", mocha, stdio: "inherit"
    spawnSync "./node_modules/.bin/istanbul", ["report", "text-summary", "lcov", "html"], stdio: "inherit"
    open "./coverage/lcov-report/index.html"
