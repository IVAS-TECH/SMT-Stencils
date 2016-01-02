successful = require "./../successful"

describe "successful", ->

  it "returns true if db query is successful", ->

    expect(successful null, _id: "some id").to.be.true

  it "returns false if db query failed", ->

    expect(successful new Error(), _id: "some id").to.be.false

    expect(successful new Error()).to.be.false
