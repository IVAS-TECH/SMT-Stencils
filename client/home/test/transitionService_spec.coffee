tested = require "./../transitionService"

describe "goHomeService", ->

  transitionService = $state = undefined

  beforeEach ->
    $state =
      current: name: ""
      go: ->

    transitionService = tested $state

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
