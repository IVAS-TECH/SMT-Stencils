describe "templateProvider", ->

  template = require "./../template"

  view = template "homeView"

  tested = require "./../templateProvider"

  templateProvider = tested()

  describe "$get", ->

    it "gets reference to the template supling function", ->

      expect(templateProvider.$get()).toEqual template

  describe "provide", ->

    it "suplies a view", ->

      expect(templateProvider.provide "homeView").toEqual view
