mock = require "mock"

describe "goAdminService", ->

  goAdminService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject (_goAdminService_, _$state_) ->
    goAdminService = _goAdminService_
    $state = _$state_

  it "should chage $state to 'home.admin'", ->

    spy = jasmine.createSpy $state, "go"

    expect($state.current.name).not.toEqual "home.admin"

    expect($state.go).toEqual jasmine.any Function

    goAdminService().then ->

      expect($state.current.name).toEqual "home.admin"

      expect(spy).toHaveBeenCalledWith "home.admin"
