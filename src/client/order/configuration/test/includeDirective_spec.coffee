describe "includeDirective", ->

  includeDirective = $compile = template = scopeControllerService = scope = element = compileFn = undefined

  beforeEach ->

    $compile = jasmine.createSpy()

    template = jasmine.createSpy()

    scopeControllerService = jasmine.createSpy()

    scope = $watch: jasmine.createSpy()

    element = jasmine.createSpyObj "element", ["html", "contents"]

    compileFn = jasmine.createSpy()

    $compile.and.callFake (element) ->
      compileFn

    tested = require "./../includeDirective"

    includeDirective = tested $compile, template, scopeControllerService

  describe "when scope properties are not defined", ->

    it "shouldn't do anything", ->

      includeDirective.link {}, element

      expect(scopeControllerService).not.toHaveBeenCalled()

      expect(template).not.toHaveBeenCalled()

      expect($compile).not.toHaveBeenCalled()

      expect(scope.$watch).not.toHaveBeenCalled()

      expect(element.html).not.toHaveBeenCalled()

      expect(element.contents).not.toHaveBeenCalled()

      expect(compileFn).not.toHaveBeenCalled()

  describe "when scope.controller is defined", ->

    it "should call scopeControllerService with scope", ->

      scope.controller = "ctrl"

      includeDirective.link scope, element

      expect(scopeControllerService).toHaveBeenCalledWith scope

  describe "when include is defined", ->

    html = "html"

    beforeEach ->

      element.contents.and.callFake -> html

    describe "when template is 'true'", ->

      it "should set inner html with the reuslt from binding current scope and html returned from template", ->

        scope.include = "template"

        template.and.callFake -> html

        includeDirective.link scope, element, template: "true"

        expect(element.html).toHaveBeenCalledWith html

        expect(element.contents).toHaveBeenCalled()

        expect($compile).toHaveBeenCalledWith html

        expect(compileFn).toHaveBeenCalledWith scope

    describe "when include is raw html", ->

      it "should set inner html with the reuslt from binding current scope and include", ->

        scope.$watch.and.callFake (prop, cb) ->
          cb html

        scope.include = html

        includeDirective.link scope, element, {}

        expect(element.html).toHaveBeenCalledWith html

        expect(element.contents).toHaveBeenCalled()

        expect($compile).toHaveBeenCalledWith html

        expect(compileFn).toHaveBeenCalledWith scope
