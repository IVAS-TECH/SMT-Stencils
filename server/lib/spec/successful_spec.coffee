successful = require "./../successful"

describe "successful", ->

  it "returns true if db query is successful", ->

    success = successful null, _id: "some id"

    expect(success).to.equal true

  it "returns false if db query failed", ->

    success = successful new Error(), _id: "some id"

    expect(success).to.equal false

    success = successful new Error()

    expect(success).to.equal false
