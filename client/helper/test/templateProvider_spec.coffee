describe "templateProvider", ->

  proxyquire = require "proxyquire"

  view = "html"

  template = (tmp) -> view

  tested = proxyquire "./../templateProvider", "./template": template

  templateProvider = tested()

  describe "$get", ->

    it "gets reference to the template supling function", ->

      expect(templateProvider.$get()).toEqual template

  describe "provide", ->

    it "suplies a view", ->

      expect(templateProvider.provide "view").toEqual view
