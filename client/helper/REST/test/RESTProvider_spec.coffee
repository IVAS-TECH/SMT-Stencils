describe "RESTProvider", ->

  RESTProvider = undefined

  describe "setBase", ->

    beforeEach ->

      tested = require "./../RESTProvider"

      RESTProvider = tested()

    it "sets base path for all reqests", ->

      expect(RESTProvider.getBase()).not.toEqual "api"

      RESTProvider.setBase "api"

      expect(RESTProvider.getBase()).toEqual "api"

  describe "REST", ->

    REST = undefined

    beforeEach ->

      proxyquire = require "proxyquire"

      request = ->

      tested = proxyquire "./../RESTProvider", http:
        request: request
        "@noCallThru": true

      RESTProvider = tested()

      RESTProvider.setBase "api"

      REST = RESTProvider.$get()
