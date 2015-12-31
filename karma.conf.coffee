module.exports = (config) ->
  config
    .set
      basePath: ""
      frameworks: ["jasmine"]
      files: [
        #"server/*_spec.js",
        #"server/*.js",
        #"client/app/final/.js"
        #"client/*_spec.js"
        "test.js"
        "test_spec.js"
      ]
      exclude: []
      preprocessors: {}
      reporters: ["progress", "coverage"]
      preprocessors:
        "test.js": ["coverage"]
      coverageReporter:
        type : "html",
        dir : "coverage/"
      port: 9876
      colors: true
      logLevel: config.LOG_INFO
      autoWatch: false
      browsers: [
        "Chrome"
        #"Firefox" add to package.json::devDependencies:["karma-firefox-launcher"]
        #"PhantomJS" add to package.json::dependencies:["phantomjs"] and package.json::devDependencies["karma-phantomjs-launcher"]
      ]
      singleRun: true
      concurrency: Infinity
