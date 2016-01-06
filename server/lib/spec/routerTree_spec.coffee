describe "routerTree", ->

  last = handle = spies = routerTree = proxyquire = undefined

  methods = [
    "get"
    "post"
    "put"
    "patch"
    "delete"
  ]

  special = [
    "param"
    "beforeEach"
    "afterEach"
    "use"
  ]

  cb = ->

  before ->

    proxyquire = require "proxyquire"

  beforeEach ->

    last = methods.length

    handle = {}

    handle[method] = cb for method in methods

    class Router
      constructor: ->

    methods.push special[3]

    Router::[method] = cb for method in methods

    spies = (sinon.spy Router.prototype, method for method in methods)

    methods.pop()

    routerTree = sinon.spy proxyquire "./../routerTree", "express": Router: Router

  it "builds restful router", ->

    router = routerTree handle

    expect(routerTree).to.have.been.calledOnce

    expect(spies[last]).to.have.not.been.called

    for index of methods
      expect(spies[index]).to.have.been.calledWith "/", cb

  it "adds param to router if param has been passed and method is get/delete", ->

    handle.param = "param"

    router = routerTree handle

    expect(routerTree).to.have.been.calledOnce

    expect(spies[last]).to.have.not.been.called

    for method in methods
      if method in [methods[0], methods[4]]
        expect(spies[methods.indexOf method]).to.have.been.calledWith "/:param", cb
      else
        expect(spies[methods.indexOf method]).to.have.been.calledWith "/", cb

  it "adds param to router if param has been specified for a method", ->

    handle.param = get: "param"

    router = routerTree handle

    expect(routerTree).to.have.been.calledOnce

    expect(spies[last]).to.have.not.been.called

    for method in methods
      if method is methods[0]
        expect(spies[methods.indexOf method]).to.have.been.calledWith "/:param", cb
      else
        expect(spies[methods.indexOf method]).to.have.been.calledWith "/", cb

  it "makes a recursevive call if non method or special is provided as key and adds that router by using it on /\#{key}", ->

    handle.route1 =
      get: cb
      post: cb
      put: cb
      route2:
        delete: cb
        patch: cb

    router = routerTree handle

    expect(routerTree).to.have.been.calledTrice

    expect(spies[last]).to.have.been.calledTwice

    for index of methods
      expect(spies[index]).to.have.been.calledWith "/", cb

  it "calls router.use with provided beforeEach if there is 1 on the handler before iterating the rest", ->

    beforeEach = [cb, cb]

    handle.beforeEach = beforeEach

    router = routerTree handle

    expect(spies[last])
      .to.have.been.calledOnce
      .and.calledBefore spies[0]
      .and.calledWithExactly "\/", beforeEach


  it "calls router.use with provided afterEach if there is 1 on the handler after iterating the rest", ->

    afterEach = [cb, cb]

    handle.afterEach = afterEach

    router = routerTree handle

    expect(spies[last])
      .to.have.been.calledOnce
      .and.calledAfter spies[0]
      .and.calledWithExactly "\/", afterEach
