session = require "./../session"

describe "session", ->

  midleware = undefined

  beforeEach -> midleware = session()

  describe "req.ip", ->

    req = undefined

    beforeEach ->
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
      req =
        connection:
          remoteAddress: "127.0.0.1"

    it "creates new Session that maches the req.ip", ->
      midleware req
      expect(req.session.ip).to.equal "127.0.0.1"
