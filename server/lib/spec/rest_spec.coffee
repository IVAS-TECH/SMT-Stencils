describe "rest", ->

  spies = rest = proxyquire = undefined

  methods = [
    "get"
    "post"
    "put"
    "patch"
    "delete"
  ]

  cb = ->

  handle = {}

  handle[method] = cb for method in methods

  before ->

    proxyquire = require "proxyquire"
    proxyquire.noCallThru()

  beforeEach ->

    class Router
      constructor: ->

    Router::[method] = cb for method in methods

    spies = (sinon.spy Router.prototype, method for method in methods)

    rest = proxyquire "./../rest", "express": Router: Router

  afterEach -> spy.restore() for spy in spies

  after -> proxyquire.callThru()

  it "builds restful router", ->

    router = rest "test", handle

    for index of methods
      expect(spies[index]).to.have.been.calledWith "/test", cb

  it "adds param to router if param has been passed and method is get/delete", ->

    router = rest "test", handle, "param"

    for method in methods
      if method in [methods[0], methods[4]]
        expect(spies[methods.indexOf method]).to.have.been.calledWith "/test/:param", cb
      else
        expect(spies[methods.indexOf method]).to.have.been.calledWith "/test", cb
