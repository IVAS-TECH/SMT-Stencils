describe "session", ->

  req = proxyquire = session = midleware = undefined

  before -> proxyquire = require "proxyquire"

  describe "req.session.ip", ->

    spy = undefined

    before ->

      spy = sinon.spy()

      session = proxyquire "./../session", "./Session": spy

      midleware = session()

    beforeEach ->

      req =
        connection:
          remoteAddress: undefined
          _peername:
            address: undefined

    it "calls Session with req.connection.remoteAddress", ->
      req.connection.remoteAddress = "127.0.0.1"
      midleware req
      expect(spy).to.have.been.calledWith req.connection.remoteAddress

      req.connection._peername.address = "0.0.0.0"
      midleware req
      expect(spy).to.have.been.calledWith  req.connection.remoteAddress

    it "scalls Session with req.connection._peername.address", ->
      req.connection._peername.address = "127.0.0.1"
      midleware req
      expect(spy).to.have.been.calledWith  req.connection._peername.address

  describe "it lets next req handler to execute", ->

    before ->

      req =
        connection:
          remoteAddress: "127.0.0.1"

      proxyquire = require "proxyquire"

    describe "if DB Query Succed it simply calls next", ->

      beforeEach ->

        class mockSession
          restore: ->
            then: (resolve) ->
              resolve()

        session = proxyquire "./../session", "./Session": mockSession

        midleware = session()

      it "calls next() when session is restore for use", ->

        spy = sinon.spy()

        midleware req, {}, spy

        expect(spy).to.have.been.calledOnce

    describe "if DB Query failed it 'throws' the error by calling next with error", ->

      error = undefined

      beforeEach ->

        error = new Error "some error"

        class mockSession
          restore: ->
            then: (resolve, reject) ->
              reject error

        session = proxyquire "./../session", "./Session": mockSession

        midleware = session()

      it "calls next() when session is restore and ready for use", ->

        next = (err) ->

        spy = sinon.spy next

        midleware req, {}, spy

        expect(spy).to.have.been.calledOnce.calledWithExactly error
