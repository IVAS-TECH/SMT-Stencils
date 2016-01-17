describe "addressDirective", ->

  tested = require "./../addressDirective"

  stop = addressDirective = scope = undefined

  value = yes

  beforeEach ->

    stop = jasmine.createSpy()

    scope = jasmine.createSpyObj "scope", ["$watch", "$emit", "$on"]

    scope.$watch.and.callFake (event, cb) ->
      cb value
      stop

    scope.$on.and.callFake (event, cb) -> cb()

    addressDirective = tested ->

  describe "link", ->

    it "should emit 'address-validity' and current value and when scope is destroied to stop emiting", ->

      scope.name = "delivery"

      addressDirective.link scope

      expect(scope.$emit).toHaveBeenCalledWith "address-validity", "delivery", value

      expect(stop).toHaveBeenCalled()
