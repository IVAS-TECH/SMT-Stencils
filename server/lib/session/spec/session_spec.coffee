

describe "session", ->
  session = midleware = undefined

  beforeEach ->
    session = require "./../session"
    midleware = session()

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
