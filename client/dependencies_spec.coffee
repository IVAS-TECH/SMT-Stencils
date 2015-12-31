dependencies = undefined

beforeEach ->
  dependencies = require "./dependencies"

describe "dependencies", ->
  it "should containt all browser dependencies as packages or angular module names", ->
    expect(dependencies).toEqual jasmine.objectContaining
      "angular-animate": "ngAnimate"
      "angular-aria": "ngAria"
      "angular-messages": "ngMessages"
      "angular-material": "ngMaterial"
      "ng-file-upload": "ngFileUpload"
    expect(dependencies.angular).toBeDefined()
    expect(dependencies.angular).toEqual jasmine.any Object
    expect(dependencies.angular).toEqual jasmine.objectContaining
      module: jasmine.any Function
      element: jasmine.any Function
