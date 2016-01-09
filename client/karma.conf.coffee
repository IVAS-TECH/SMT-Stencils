instanbul = require "browserify-istanbul"

module.exports = (config) ->
  config
    .set
      basePath: ""
      frameworks: ["browserify", "jasmine"]
      files: ["**/*_spec.js"]
      exclude: ["karma.conf.js", "app/*", "helper/template.js"]
      reporters: ["mocha", "coverage"]
      preprocessors:
        "**/*_spec.js": ["browserify"]
      browserify:
        debug: true
        transform: [instanbul]
        plugin: ["proxyquire-universal"]
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
