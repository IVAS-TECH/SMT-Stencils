describe "userRouter", ->

  api = proxyquire = undefined

  before ->

    proxyquire = require "proxyquire"

    proxyquire.noCallThru()

    api = proxyquire "./../userHandle", "./../../userModel": ivo: 3

  after -> proxyquire.callThru()
