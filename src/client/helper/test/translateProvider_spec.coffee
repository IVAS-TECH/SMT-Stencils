describe "translateProvider", ->

  tested = require "./../translateProvider"

  translations = jasmine.createSpy()

  $translateProvider = translations: translations

  translateProvider = tested $translateProvider

  describe "$get", ->

    it "gets reference to the real $translateProvider", ->

      expect(translateProvider.$get()).toEqual $translateProvider

  describe "add", ->

    it "adds both en and bg translations with single call", ->

      en = test: "test"

      bg = test: "тест"

      translateProvider.add en, bg

      expect(translations).toHaveBeenCalledWith "en", en

      expect(translations).toHaveBeenCalledWith "bg", bg
