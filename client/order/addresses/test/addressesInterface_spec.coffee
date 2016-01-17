describe "addressesInterface", ->

  addressesInterface = stop = undefined

  beforeEach ->

    $controller = -> valid: []

    dependecy = ->

    $scope = $on: jasmine.createSpy()

    stop = jasmine.createSpy()


    $scope.$on.and.callFake (event, cb) ->
      if event is "$destroy" then cb()
      else
        cb null, name, no for name in ["delivery", "invoice", "firm"]
        stop

    tested = require "./../addressesInterface"

    addressesInterface = tested $controller, $scope, dependecy, dependecy, dependecy, dependecy

  describe "once instanced", ->

    it "should have valid set to [no, no, no]", ->

      expect(addressesInterface.valid).toEqual [no, no, no]

      expect(addressesInterface.btnBack).toBe yes

      expect(stop).toHaveBeenCalled()

  describe "fill", ->

    it "auto fills address field based on selected src", ->

      addressesInterface.addressesObject = firm: {}

      addressesInterface.addressesObject.delivery =
        country: "Bulgaria"
        city: "Sofia"
        postcode: "1000"
        address1: "St. 1"
        address2: "St. 2"
        firstname: "Ivo"
        lastname: "Stratev"

      addressesInterface.fill "firm", "delivery"

      expect(addressesInterface.addressesObject.firm).toEqual addressesInterface.addressesObject.delivery
