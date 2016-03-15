describe "showErrorService", ->

  tested = require "./../showErrorService"

  showErrorService = tested()

  it "should return false if is called with none object", ->

      expect(showErrorService "object").toBe no

  it "should return false if is called with undefined", ->

      expect(showErrorService null).toBe no

  it "should return false if is called with empty object", ->

      expect(showErrorService {}).toBe no

  it "should return true if is called with none empty object", ->

      expect(showErrorService required: yes).toBe yes
