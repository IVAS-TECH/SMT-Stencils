fs = require "fs"
del = require "del"
nib = require "nib"
gulp = require "gulp"
jade = require "gulp-jade"
gutil = require "gulp-util"
html = require "gulp-htmlmin"
vinyl = require "vinyl-paths"
coffee = require "gulp-coffee"
stylus = require "gulp-stylus"
inline = require "gulp-inline"
concat = require "gulp-concat"
uglify = require "gulp-uglify"
browserify = require "browserify"
uglifyCSS = require "gulp-uglifycss"
source = require "vinyl-source-stream"
templateCache = require "gulp-angular-templatecache"
{spawnSync} = require "child_process"

gulp.task "clean", ->
  del.sync ["./templates", "./build", "./resources"]

gulp.task "clear", ["clean"], ->
  del.sync ["./deploy"]

gulp.task "jade", ["clear"], ->
  gulp
    .src "./client/**/*.jade"
    .pipe jade jade: require "jade"
    .pipe html
      collapseWhitespace: yes
      conservativeCollapse: yes
      collapseInlineTagWhitespace: yes
    .on "error", gutil.log
    .pipe gulp.dest "./templates"

gulp.task "error", ["jade"], ->
  gulp
    .src "./templates/error.html"
    .pipe vinyl del
    .pipe gulp.dest "./build"

gulp.task "index", ["error"], ->
  gulp
    .src "./templates/index.html"
    .pipe vinyl del
    .pipe gulp.dest "./build/inline"

gulp.task "cache", ["index"], ->
  gulp
    .src "./templates/**/*.html"
    .pipe vinyl del
    .pipe templateCache "templates.js",
      moduleSystem: "Browserify"
      standalone: yes
      transformUrl: (url) ->
        struc = (url.split ".")[0].split "/"
        struc[struc.length - 1]
    .pipe gulp.dest "./build"

gulp.task "client", ["cache"], ->
  gulp
    .src "./client/**/*.coffee"
    .pipe coffee bare: no
    .on "error", gutil.log
    .pipe gulp.dest "./build"

gulp.task "server", ["client"], ->
  gulp
    .src "./server/**/*.coffee"
    .pipe coffee bare: no
    .on "error", gutil.log
    .pipe gulp.dest "./deploy"

gulp.task "browserify", ["server"], ->
  stream = fs.createWriteStream "./build/bundle.js"
  (browserify "./build/main.js").bundle (err, bundle) ->
    stream.write bundle, (err) ->
      if err then gutil.log err else stream.end()
  stream

gulp.task "uglify", ["browserify"], ->
  gulp
    .src "./build/bundle.js"
    .pipe uglify
      mangle: yes
      copress:
        screw_ie8: yes
        sequences: yes
        dead_code: yes
        conditionals: yes
        booleans: yes
        unused: yes
        if_return: yes
        join_vars: yes
        drop_console: yes
    .pipe gulp.dest "./build/inline"

gulp.task "stylus", ["uglify"], ->
  gulp
    .src "./client/styles/style.styl"
    .pipe stylus
      compress: yes
      use: nib()
    .pipe uglifyCSS
      "max-line-len": 1
      "expand-vars": no
    .pipe gulp.dest "./build"

gulp.task "styles", ["stylus"], ->
  gulp
    .src [
      "./build/style.css"
      "./node_modules/angular-material/angular-material.min.css"
      "./node_modules/angular-chart.js/dist/angular-chart.min.css"
    ]
    .pipe concat "style.css"
    .pipe uglifyCSS
      "max-line-len": 1
      "expand-vars": no
      "ugly-comments": yes
      "cute-comments": no
    .pipe gulp.dest "./build/inline"

gulp.task "bundle", ["styles"], ->
  gulp
    .src "./build/inline/index.html"
    .pipe inline base: "./build/inline"
    .pipe gulp.dest "./build/send"

gulp.task "clone", ["bundle"], ->
  spawnSync "git", [
    "clone"
    "https://github.com/IVAS-TECH/SMT-Stencils_resources.git"
    "./resources"
  ], stdio: "inherit"

gulp.task "preview", ["clone"], ->
  gulp
    .src "./resources/top.html"
    .pipe gulp.dest "./deploy/send"

gulp.task "favicon", ["preview"], ->
  gulp
    .src "./resources/favicon.ico"
    .pipe gulp.dest "./deploy/send"

gulp.task "deploy", ["favicon"], ->

gulp.task "build", ["deploy"]
