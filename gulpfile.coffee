del = require "del"
nib = require "nib"
gulp = require "gulp"
jade = require "gulp-jade"
gutil = require "gulp-util"
html = require "gulp-htmlmin"
vinyl = require "vinyl-paths"
coffee = require "gulp-coffee"
stylus = require "gulp-stylus"
concat = require "gulp-concat"
browserify = require "browserify"
uglifyCSS = require "gulp-uglifycss"
templateCache = require "gulp-angular-templatecache"
{spawnSync} = require "child_process"

gulp.task "client", ->
  gulp
    .src "./client/**/*.coffee"
    .pipe coffee bare: no
    .on "error", gutil.log
    .pipe gulp.dest "./build"

gulp.task "jade", ->
  gulp
    .src "./client/**/*.jade"
    .pipe jade jade: require "jade"
    .pipe html
      collapseWhitespace: yes
      conservativeCollapse: yes
      collapseInlineTagWhitespace: yes
    .pipe gulp.dest "./templates"

gulp.task "clone", ->
  spawnSync "git", ["clone", "https://github.com/IVAS-TECH/SMT-Stencils_resources.git", "./resources"], stdio: "inherit"

gulp.task "preview", ->
  gulp
    .src "./resources/top.html"
    .pipe gulp.dest "./deploy/send"

gulp.task "index", ->
  gulp
    .src "./client/index.html"
    .pipe gulp.dest "./build"

gulp.task "error", ->
  gulp
    .src "./client/error.html"
    .pipe gulp.dest "./build"

gulp.task "resources", ["clone", "preview"], ->

gulp.task "templates", ["jade", "index", "error", "resources"], ->
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

gulp.task "server", ->
  gulp
    .src "./server/**/*.coffee"
    .pipe coffee bare: no
    .on "error", gutil.log
    .pipe gulp.dest "./deploy"

gulp.task "stylus", ->
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
    .src ["./build/style.css", "./node_modules/angular-material/angular-material.min.css", "./node_modules/angular-chart.js/dist/angular-chart.min.css"]
    .pipe concat "style.css"
    .pipe uglifyCSS
      "max-line-len": 1
      "expand-vars": no
      "ugly-comments": yes
      "cute-comments": no
    .pipe gulp.dest "./build"

gulp.task "browserify", ["client", "templates"], ->
  gulp
    .src "./build/main.js"
    .pipe (file) -> (browserify file).bundle()
    .pipe uglify()
    .pipe gulp.dest "./build"

gulp.task "bundle", ["browserify", "styles"], ->

gulp.task "favicon", ->
  gulp
    .src "./resources/favicon.ico"
    .pipe gulp.dest "./deploy/send"

gulp.task "clean", ->
  del.sync ["./templates", "./build", "./resources"]

gulp.task "clear", ["clean"], ->
  del.sync ["./deploy"]

gulp.task "deploy", ["bundle", "server", "favicon"], ->

gulp.task "build", ["clear", "deploy", "clean"], ->
