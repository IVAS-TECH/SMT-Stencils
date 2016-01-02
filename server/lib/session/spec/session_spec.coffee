describe "session", ->

  session = midleware = undefined

  describe "req.ip", ->

    req = undefined

    beforeEach ->

      session = require "./../session"

      midleware = session()

      req =
        connection:
          remoteAddress: undefined
          _peername:
            address: undefined

    it "sets ip value to be req.connection.remoteAddress", ->
      req.connection.remoteAddress = "127.0.0.1"
      midleware req
      expect(req.ip).to.equal req.connection.remoteAddress

      req.connection._peername.address = "0.0.0.0"
      midleware req
      expect(req.ip).to.equal req.connection.remoteAddress

    it "sets ip value to be req.connection._peername.address", ->
      req.connection._peername.address = "127.0.0.1"
      midleware req
      expect(req.ip).to.equal req.connection._peername.address

  describe "req.session", ->

    req = undefined

    beforeEach ->

      session = require "./../session"
      midleware = session()
      req =
        connection:
          remoteAddress: "127.0.0.1"

    it "creates new Session that maches the req.ip", ->
      midleware req
      expect(req.session.ip).to.equal "127.0.0.1"

  describe "it lets next req handler to execute", ->

    proxyquire = req = undefined

    beforeEach ->

      proxyquire = require "proxyquire"

      req =
        connection:
          remoteAddress: "127.0.0.1"

    describe "if DB Query Succed it simply calls next", ->

      beforeEach ->

        class mockSession
          ready: ->
            then: (resolve) ->
              resolve()

        session = proxyquire "./../session", "./Session": mockSession

        midleware = session()

      it "calls next() when session is ready for use", ->

        spy = sinon.spy()

        midleware req, {}, spy

        expect(spy).to.have.been.calledOnce

    describe "if DB Query failed it 'throws' the error by calling next with error", ->

      error = undefined

      beforeEach ->

        error = new Error "some error"

        class mockSession
          ready: ->
            then: (resolve, reject) ->
              reject error

        session = proxyquire "./../session", "./Session": mockSession

        midleware = session()

      it "calls next() when session is ready for use", ->

        next = (err) ->

        spy = sinon.spy next

        midleware req, {}, spy

        expect(spy).to.have.been.calledOnce.calledWithExactly error
