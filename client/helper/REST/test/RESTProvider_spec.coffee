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

        expect(data.statusCode).toEqual 200

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

    describe "REST.get", ->

      it "makes get request if no argumnt is passed empty string will take it place", (done) ->

        resource.get().then (data) ->

          expect(resource.make).toHaveBeenCalledWith "GET", ""

          done()

    describe "REST.post", ->

      it "makes post request if no argumnt is passed empty object will take it place", (done) ->

        resource.post().then (data) ->

          expect(resource.make).toHaveBeenCalledWith "POST", {}

          done()

    describe "REST.put", ->

      it "makes put request if no argumnt is passed empty object will take it place", (done) ->

        resource.put().then (data) ->

          expect(resource.make).toHaveBeenCalledWith "PUT", {}

          done()

    describe "REST.delete", ->

      it "makes delete request if no argumnt is passed empty string will take it place", (done) ->

        resource.delete().then (data) ->

          expect(resource.make).toHaveBeenCalledWith "DELETE", ""

          done()

    describe "REST.patch", ->

      it "makes put request if no argumnt is passed empty object will take it place", (done) ->

        resource.patch().then (data) ->

          expect(resource.make).toHaveBeenCalledWith "PATCH", {}

          done()

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
