module.exports =
  name:
    type: String
    unique: yes
    required: yes
    mongoose: yes
  user: "User"
  fudical:
    marks: String
    side: String
  position:
    aligment: String
    position: String
    side: String
  stencil:
    transitioning: String
    type: String
    impregnation: Boolean
    frame:
      size: String
      clean: Boolean
  text:
    angle: String
    position: String
    side: String
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
