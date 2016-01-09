describe "session", ->

  session = midleware = undefined

  req = res = {}

  proxyquire = require "proxyquire"

  getClientIp = -> "195.163.2.108"

  describe "it lets next req handler to execute", ->

    describe "if DB Query Succed it simply calls next", ->

      beforeEach ->

        class mockSession
          restore: ->
            then: (resolve) ->
              resolve()

        session = proxyquire "./../session",
          "./Session": mockSession
          "request-ip": getClientIp: getClientIp

        midleware = session()

      it "calls next() when session is restore for use", ->

        spy = sinon.spy()

        midleware req, res, spy

        expect(spy).to.have.been.calledOnce

    describe "if DB Query failed it 'throws' the error by calling next with error", ->

      error = undefined

      beforeEach ->

        error = new Error "some error"

        class mockSession
          restore: ->
            then: (resolve, reject) ->
              reject error

        session = proxyquire "./../session",
          "./Session": mockSession
          "request-ip": getClientIp: getClientIp

        midleware = session()

      it "calls next() when session is restore and ready for use", ->

        next = (err) ->

        spy = sinon.spy next

        midleware req, res, spy

        expect(spy).to.have.been.calledOnce.calledWithExactly error
