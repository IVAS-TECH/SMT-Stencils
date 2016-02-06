gulp = require "gulp"
jade = require "gulp-jade"
coffee = require "gulp-coffee"
html = require "gulp-htmlmin"
templateCache = require "gulp-angular-templatecache"

gulp.task "jade", ->
  gulp
    .src "./client/**/*.jade"
    .pipe jade jade: require "jade"
    .pipe html
      collapseWhitespace: yes
      conservativeCollapse: yes
      collapseInlineTagWhitespace: yes
    .pipe gulp.dest "./templates"

gulp.task "test", ["jade"], ->
  gulp
    .src "./templates/**/*.html"
    .pipe templateCache "templates.js",
      moduleSystem: "Browserify"
      transformUrl: (url) ->
        struc = (url.split ".")[0].split "/"
        struc[struc.length - 1]
    .pipe gulp.dest "./client"
