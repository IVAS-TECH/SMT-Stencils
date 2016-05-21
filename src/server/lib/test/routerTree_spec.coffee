describe "routerTree", ->
    routerTree = Router = router = config = request = undefined

    beforeEach ->
        proxyquire = require "proxyquire"
        router =
            use: sinon.spy()
            param: sinon.spy()
            get: sinon.spy()
            post: sinon.spy()
            put: sinon.spy()
            patch: sinon.spy()
            delete: sinon.spy()
        Router = sinon.stub()
        Router.returns router
        routerTree = proxyquire "./../routerTree", "express": Router: Router

    it "should call use with beforeEach: value if it exist on the config object", ->
        config =
            beforeEach: ->
            get: ->
        routerTree config
        (expect Router).to.have.been.calledWithNew
        (expect router.use).to.have.been.calledWithExactly "/", config.beforeEach
        (expect router.use).to.have.been.calledBefore router.get

        config.get()
        config.beforeEach()

    it "should make a recursive call if a key ins't special (it's concidered to be nested router config)", ->
        config =
            get: ->
            test:
                get: ->
        routerTree config
        (expect router.get).to.have.been.calledTwice
        (expect Router).to.have.been.alwaysCalledWithNew
        (expect router.get.firstCall).to.have.been.calledWithExactly "/", config.get
        (expect router.get.secondCall).to.have.been.calledWithExactly "/", config.test.get
        (expect router.use).to.have.been.calledWithExactly "/test", router
        (expect router.use).to.have.been.calledBefore router.get.secondCall

        config.get()
        config.test.get()

    it "should add params to get and delete if params is String", ->
        config =
            get: ->
            delete:->
            params: "test"
        routerTree config
        (expect router.get).to.have.been.calledWithExactly "/:test", config.get
        (expect router.delete).to.have.been.calledWithExactly "/:test", config.delete

        config.get()
        config.delete()

    it "should call router.param and add params to get and delete if params is \n\t{\n\t\tname: String,\n\t\tcallback: Function\n\t}", ->
        config =
            get: ->
            delete:->
            params:
                name: "test"
                callback: ->
        routerTree config
        (expect router.get).to.have.been.calledWithExactly "/:test", config.get
        (expect router.delete).to.have.been.calledWithExactly "/:test", config.delete
        (expect router.param).to.have.been.calledWithExactly config.params.name, config.params.callback
        (expect router.param).to.have.been.calledBefore router.get
        (expect router.param).to.have.been.calledBefore router.delete

        config.get()
        config.delete()
        config.params.callback()

    it "should add param to get or delete if there is one for them in params object", ->
        config =
            get: ->
            delete: ->
            params:
                get: "test"
                delete: "ok"
        routerTree config
        (expect router.get).to.have.been.calledWithExactly "/:test", config.get
        (expect router.delete).to.have.been.calledWithExactly "/:ok", config.delete

        config.get()
        config.delete()

    it "should call router.param and add param to get or delete if there is one for them in params object and it is named callback, eg. if params is \n\t{\n\t\tget: {\n\t\t\tname: String,\n\t\t\tcallback: Function\n\t\t}\n\t}", ->
        config =
            get: ->
            params:
                get:
                    name: "test"
                    callback: ->
        routerTree config
        (expect router.get).to.have.been.calledWithExactly "/:test", config.get
        (expect router.param).to.have.been.calledWithExactly config.params.get.name, config.params.get.callback
        (expect router.param).to.have.been.calledBefore router.get

        config.get()
        config.params.get.callback()

    it "should apply all arguments as if a manual function call was made, if value is Array", ->
        config = get: [(->), (->)]
        routerTree config
        (expect router.get).to.have.been.calledWithExactly "/", config.get[0], config.get[1]

        config.get[0]()
        config.get[1]()

    it "should call router.use afterEach after all router calls", ->
        config =
            beforeEach: ->
            afterEach: ->
            get: ->
        routerTree config
        (expect router.use).to.have.been.calledTwice
        (expect router.use).to.have.been.calledWithExactly "/", config.beforeEach
        (expect router.use).to.have.been.calledWithExactly "/", config.afterEach
        (expect router.get).to.have.been.calledWithExactly "/", config.get
        (expect router.get).to.have.been.calledBefore router.use.secondCall

        config.beforeEach()
        config.get()
        config.afterEach()

    it "should properly make the router hierarchy", ->
        config =
            beforeEach: ->
            afterEach: ->
            get: ->
            params:
                name: "test"
                callback: ->
            test:
                get: ->
                delete: ->
                patch: ->
                put: ->
                post: ->
                params:
                    delete:
                        name: "name"
                        callback: ->
                    get: "match"
        routerTree config
        (expect Router).to.have.been.alwaysCalledWithNew
        (expect Router).to.have.been.calledTwice
        (expect router.get).to.have.been.calledTwice
        (expect router.param).to.have.been.calledTwice
        (expect router.use).to.have.been.calledTrice
        (expect router[method]).to.have.been.calledOnce for method in ["delete", "post", "put", "patch"]
        (expect router.param.firstCall).to.have.been.calledWithExactly "test", config.params.callback
        (expect router.param.secondCall).to.have.been.calledWithExactly "name", config.test.params.delete.callback
        (expect router.use.firstCall).to.have.been.calledWithExactly "/", config.beforeEach
        (expect router.use.secondCall).to.have.been.calledWithExactly "/test", router
        (expect router.use.lastCall).to.have.been.calledWithExactly "/", config.afterEach
        (expect router.delete).to.have.been.calledWithExactly "/:name", config.test.delete
        (expect router[method]).to.have.been.calledWithExactly "/", config.test[method] for method in ["post", "put", "patch"]
        (expect router.get.firstCall).to.have.been.calledWithExactly "/:test", config.get
        (expect router.get.secondCall).to.have.been.calledWithExactly "/:match", config.test.get

        config.beforeEach()
        config.get()
        config.afterEach()
        config.beforeEach()
        config.params.callback()
        config.test.get()
        config.test.delete()
        config.test.patch()
        config.test.put()
        config.test.post()
        config.test.params.delete.callback()
