mock = require "mock"

describe "goHomeService", ->

  transitionService = $state = undefined

  beforeEach mock.module "main"

  beforeEach mock.inject (_transitionService_, _$state_) ->
    $state = _$state_
    transitionService = _transitionService_

  it "should chage $state to 'home.about'", () ->

    spyOn($state, "go").and.callFake (transition) ->
      $state.current.name = "home.about"

    expect($state.current.name).not.toEqual "home.about"

    transitionService.toHome()

    expect($state.go).toHaveBeenCalledWith "home.about"

    expect($state.current.name).toEqual "home.about"

  it "should chage $state to 'home.admin'", () ->

    spyOn($state, "go").and.callFake (transition) ->
      $state.current.name = "home.admin"

    expect($state.current.name).not.toEqual "home.admin"

    transitionService.toAdmin()

    expect($state.go).toHaveBeenCalledWith "home.admin"

    expect($state.current.name).toEqual "home.admin"
