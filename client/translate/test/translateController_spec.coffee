describe "translateController", ->

  tested = require "./../translateController"

  translateCtrl = $translate = undefined

  beforeEach ->

    $translate = use: jasmine.createSpy()

  it "should be in default state", ->

    $translate.use.and.callFake -> "bg"

    translateCtrl = tested $translate

    expect(translateCtrl.languages).toEqual ["bg", "en"]

    expect(translateCtrl.current).toEqual "bg"

  it "should change language to provided language when called", ->

    translateCtrl = tested $translate

    translateCtrl.change "en"

    expect($translate.use).toHaveBeenCalledWith "en"
