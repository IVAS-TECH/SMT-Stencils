describe "userRouter", ->

  proxyquire = undefined

  before ->

    proxyquire = require "proxyquire"

    proxyquire.noCallThru()

  after -> proxyquire.callThru()

  describe "", ->
