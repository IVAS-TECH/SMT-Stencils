describe "configurationInfoDirective", ->

  tested = require "./../configurationInfoDirective"

  stop = configurationInfoDirective = scopeControllerService = scope = undefined

  template = ->

  value = yes

  beforeEach ->

    scopeControllerService = jasmine.createSpy()

    stop = jasmine.createSpy()

    scope = jasmine.createSpyObj "scope", ["$watch", "$emit", "$on"]

    scope.$watch.and.callFake (event, cb) ->
      cb value
      stop

    scope.$on.and.callFake (event, cb) -> cb()

    configurationInfoDirective = tested template, scopeControllerService

  describe "link", ->

    it "should emit 'config-validity' and current value and when scope is destroied to stop emiting", ->

      configurationInfoDirective.link scope

      expect(scopeControllerService).toHaveBeenCalledWith scope

      expect(scope.$emit).toHaveBeenCalledWith "config-validity", value

      expect(stop).toHaveBeenCalled()
