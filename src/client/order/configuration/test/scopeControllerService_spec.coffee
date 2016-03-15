describe "scopeControllerService", ->

  tested = require "./../scopeControllerService"

  scopeControllerService = tested()

  controller = "ctrl"
  instance = memeber: "value"

  scope = undefined

  beforeEach ->

    scope =
      controller: controller
      $parent:
        someCtrl: {}
        $parent:
          "#{controller}": instance
          $parent:
            otherCtrl: {}

  describe "when provided controller instance is found on $parent chain", ->

    it "should simulate universal scope inheritance bound to scopeCtrl by obtaining reference to controller", ->

      scopeControllerService scope

      expect(scope.scopeCtrl).toEqual instance

  describe "when provided controller instance is not found on $parent chain", ->

    it "shouldn't create scopeCtrl on scope if scope.controller isn't found", ->

      scope.controller = "notFoundCtrl"

      scopeControllerService scope

      expect(scope.scopeCtrl).toBeUndefined()

  describe "when no controller is provided", ->

    it "shouldn't create scopeCtrl on scope", ->

      delete scope.controller

      scopeControllerService scope

      expect(scope.scopeCtrl).toBeUndefined()
