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

    request = res = REST = resource = undefined

    req = {}

    headers = "Content-Type": "application/json"

    beforeEach ->

      proxyquire = require "proxyquire"

      request = jasmine.createSpy()

      request.and.callFake (params, callback) ->
        callback res
        req

      res =
        headers: headers
        on: (event, callback) ->
          if event is "data"
            callback "{\"ivo\""
            callback ": 9}"
          if event is "end" then callback()
        statusCode: 200

      req = {}

      req = jasmine.createSpyObj "req", ["setHeader", "write", "end"]

      tested = proxyquire "./../RESTProvider", http:
        request: request
        "@noCallThru": true

      RESTProvider = tested()

      RESTProvider.setBase "api"

      REST = RESTProvider.$get()

      resource = REST "test"

    it "makes simple get request", (done) ->

      resource.get().then (data) ->

        expect(request).toHaveBeenCalledWith
          path: "api/test"
          method: "GET"
          responseType: headers["Content-Type"],
          jasmine.any Function

        expect(data.statusCode).toEqual 200

        expect(data.data).toEqual ivo: 9

        expect(data.headers).toEqual headers

        done()
