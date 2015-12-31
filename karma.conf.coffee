module.exports = (config) ->
  config
    .set
      basePath: ""
      frameworks: ["browserify", "jasmine"]
      files: [
        #"server/*_spec.js",
        #"server/*.js",
        "client/app/final.js"
        "client/**/*_spec.js"
      ]
      exclude: []
      reporters: ["spec", "coverage"]
      preprocessors:
        "client/**/*_spec.js": ["browserify"]
        "client/app/final.js": ["coverage"]
      browserify:
        debug: true
      specReporter:
        suppressErrorSummary: false
        suppressFailed: false
        suppressPassed: false
        suppressSkipped: false
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
