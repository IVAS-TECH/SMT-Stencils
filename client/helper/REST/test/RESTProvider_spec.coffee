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

  describe "REST.make", ->

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

      req = jasmine.createSpyObj "req", ["setHeader", "write", "end"]

      tested = proxyquire "./../RESTProvider", http:
        request: request
        "@noCallThru": true

      RESTProvider = tested()

      RESTProvider.setBase "api"

      REST = RESTProvider.$get()

      resource = REST "test"

      spyOn(resource, "make").and.callThrough()

    it "makes simple get request", (done) ->

      resource.make("GET", "").then (data) ->

        expect(request).toHaveBeenCalledWith
          path: "api/test"
          method: "GET"
          responseType: headers["Content-Type"],
          jasmine.any Function

        expect(data.status).toEqual 200

        expect(data.data).toEqual ivo: 9

        expect(data.headers).toEqual headers

        expect(req.end).toHaveBeenCalled()

        done()

    it "makes get request with parameter", (done) ->

      resource.make("GET", "param").then (data) ->

        expect(request).toHaveBeenCalledWith
          path: "api/test/param"
          method: "GET"
          responseType: headers["Content-Type"],
          jasmine.any Function

        done()

    it "makes post request and sends object as body", (done) ->

      resource.make("POST", ivo: 9).then (data) ->

        expect(request).toHaveBeenCalledWith
          path: "api/test"
          method: "POST"
          responseType: headers["Content-Type"],
          jasmine.any Function

        expect(req.setHeader).toHaveBeenCalledWith "Content-Type", headers["Content-Type"]

        expect(req.setHeader).toHaveBeenCalledWith "Content-Length", 9

        expect(req.write).toHaveBeenCalledWith "{\"ivo\":9}"

        done()

    runDef = (expected) ->

      (test) ->

        describe "REST.#{test}", ->

          it "makes #{test} request if no argument is passed empty #{typeof expected} will take it place", (done) ->

            resource[test]().then (data) ->

              expect(resource.make).toHaveBeenCalledWith test.toUpperCase(), expected

              done()

    withParam = runDef ""

    withParam test for test in ["get", "delete"]

    withObject = runDef {}

    withObject test for test in ["post", "put", "patch"]

    run = (passed, def) ->

      (test) ->

        describe "REST.#{test}", ->

          it "makes #{test} request if argument is passed it shouldn't use default argument value", (done) ->

            resource[test](passed).then (data) ->

              expect(resource.make).not.toHaveBeenCalledWith test.toUpperCase(), def

              done()

    withParam = run "string", ""

    withParam test for test in ["get", "delete"]

    withObject = run object: true, {}

    withObject test for test in ["post", "put", "patch"]

  describe "REST with error", ->

    request = res = REST = resource = undefined

    req = {}

    error = new Error()

    beforeEach ->

      proxyquire = require "proxyquire"

      request = jasmine.createSpy()

      request.and.callFake (params, callback) ->
        callback res
        req

      res =
        on: (event, callback) ->
          if event is "error"
            callback error

      req = jasmine.createSpyObj "req", ["setHeader", "write", "end"]

      tested = proxyquire "./../RESTProvider", http:
        request: request
        "@noCallThru": true

      RESTProvider = tested()

      RESTProvider.setBase "api"

      REST = RESTProvider.$get()

      resource = REST "test"

    it "rejects with error", (done) ->

      resource.make("GET", "").then null, (data) ->

        expect(data).toEqual error

        done()
