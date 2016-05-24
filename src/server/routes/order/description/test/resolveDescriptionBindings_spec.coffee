describe "resolveDescriptionBindings", ->
    resolveDescriptionBindings = template = populate = undefined

    beforeEach ->
        resolveDescriptionBindings = require "./../resolveDescriptionBindings"
        populate =
            _id: "453243242342"
            price: 96.99
            "$test-it": "done"

    it "should return exactly the same array if there are no binings wich need to be resolved", ->
        template = ["line1", "line2", "line3"]
        (expect resolveDescriptionBindings template, populate).to.eql template

    it "should resolve all bindings", ->
        template = ["regular line", "&@_id", "&@price"]
        (expect resolveDescriptionBindings template, populate).to.eql ["regular line", "453243242342", "96.99"]

    it "should leave unresoled binings", ->
        template = ["regular line", "&@_id", "&@price", "&@it_Should-be-Th3=Same", "&@$test-it"]
        (expect resolveDescriptionBindings template, populate).to.eql ["regular line", "453243242342", "96.99", "&@it_Should-be-Th3=Same", "done"]
