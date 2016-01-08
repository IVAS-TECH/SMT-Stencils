tested = require "./../RESTProvider"

describe "RESTProvider", ->

  RESTProvider = undefined

  describe "setBase", ->

    beforeEach ->

      RESTProvider = tested()

    it "sets base path for all reqests", ->

      expect(RESTProvider.getBase()).not.toEqual "api"

      RESTProvider.setBase "api"

      expect(RESTProvider.getBase()).toEqual "api"
