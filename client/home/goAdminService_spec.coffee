mock = require "mock"

describe "goAdminService", ->

  goAdminService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject ($injector, _$state_) ->
    $state = _$state_
    _goAdminService_ = require "./goAdminService"
    goAdminService = $injector.invoke _goAdminService_, _goAdminService_, $state: $state

  it "should chage $state to 'home.admin'", () ->

    spy = jasmine.createSpy $state, "go"

    expect($state.current.name).not.toEqual "home.admin"

    spy.and.callFake (transition) ->
      $state.current.name = "home.admin"
      then: (resolve, reject) ->
        resolve(9)

    goAdminService().then (res) ->

      expect(res).toEqual 9

      expect(spy).toHaveBeenCalledWith "home.admin"

      expect($state.current.name).toEqual "home.admin"
