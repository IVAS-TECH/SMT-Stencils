mock = require "mock"

describe "goHomeService", ->

  goHomeService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject (_goHomeService_, _$state_) ->
    goHomeService = _goHomeService_
    $state = _$state_
    console.log s.name for s in $state.get()

  it "should chage $state to 'home.about'", ->

    spy = jasmine.createSpy $state, "go"

    expect($state.current.name).not.toEqual "home.about"

    expect($state.go).toEqual jasmine.any Function

    goHomeService()

    expect($state.current.name).toEqual "home.about"

    expect(spy).toHaveBeenCalledWith "home.about"
