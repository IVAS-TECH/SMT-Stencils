module.exports = (config) ->
  config
    .set
      basePath: ""
      frameworks: ["browserify", "jasmine"]
      files: [
        "app/final.js"
        "**/*_spec.js"
      ]
      exclude: ["karma.conf.js"]
      reporters: ["mocha", "coverage"]
      preprocessors:
        "**/*_spec.js": ["browserify"]
        "app/final.js": ["coverage"]
      browserify:
        debug: true
      coverageReporter:
        type : "html",
        dir : "coverage/"
        subdir: "html"
      port: 9876
      colors: true
      logLevel: config.LOG_INFO
      autoWatch: false
      browsers: ["Chrome"]
      singleRun: true
      concurrency: Infinity
