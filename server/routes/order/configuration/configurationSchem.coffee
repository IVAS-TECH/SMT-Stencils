module.exports =
  name: String
  user: "User"
  fudical:
    marks: String
    side: String
    number: Number
  position:
    aligment: String
    position: String
    side: String
  stencil:
    tickness: String
    transitioning: String
    type: String
    height: Number
    width: Number
    impregnation: Boolean
    frame:
      size: [String, "default"]
      clean: [Boolean, no]
  text:
    angle: String
    position: String
    side: [String, "default"]
    type: String
  style:
    frame: Boolean
    outline: Boolean
    layout: Boolean
    mode: String
    text:
      color: String
      view: String
    stencil:
      width: Number
      height: Number
