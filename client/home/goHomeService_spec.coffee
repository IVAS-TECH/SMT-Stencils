mock = require "mock"

describe "goHomeService", ->

  goHomeService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject (_goHomeService_, _$state_) ->
    goHomeService = _goHomeService_
    $state = _$state_

  it "should chage $state to 'home.about'", () ->

    spy = jasmine.createSpy $state, "go"

    expect($state.current.name).not.toEqual "home.about"

    spy.and.callFake (transition) ->
      $state.current.name = "home.about"
      then: (resolve, reject) ->
        resolve()

    goHomeService().then ->

      expect(spy).toHaveBeenCalledWith "home.about"

      expect($state.current.name).toEqual "home.about"
