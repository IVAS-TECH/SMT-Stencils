describe "stencilPreviewDirective", ->

  tested = require "./../stencilPreviewDirective"

  stencilPreviewDirective = scopeControllerService = undefined

  template = ->

  beforeEach ->

    scopeControllerService = jasmine.createSpy()

    stencilPreviewDirective = tested template, scopeControllerService

  describe "when scope.text is String", ->

    it "should destructivly assings Array[0] whit scope.text", ->

      scope = text: "Text"

      stencilPreviewDirective.link scope

      expect(scopeControllerService).toHaveBeenCalledWith scope

      expect(scope.text).toEqual ["Text"]

  describe "when scope.text is allready Array", ->

    it "shouldn't change scope.text", ->

      array = ["line1", "line2", "line3"]

      scope = text: array

      stencilPreviewDirective.link scope

      expect(scope.text).toEqual array
