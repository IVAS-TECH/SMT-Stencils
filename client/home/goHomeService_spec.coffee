mock = require "mock"

describe "goHomeService", ->

  goHomeService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject ($injector, _$state_) ->
    $state = _$state_
    _goHomeService_ = require "./goHomeService"
    goHomeService = $injector.invoke _goHomeService_, _goHomeService_, $state: $state

  it "should chage $state to 'home.about'", () ->

    spy = jasmine.createSpy $state, "go"

    expect($state.current.name).not.toEqual "home.about"

    spy.and.callFake (transition) ->
      $state.current.name = "home.about"
      then: (resolve, reject) ->
        resolve(9)

    goHomeService().then (res) ->

      expect(res).toEqual 9

      expect(spy).toHaveBeenCalledWith "home.about"

      expect($state.current.name).toEqual "home.about"
