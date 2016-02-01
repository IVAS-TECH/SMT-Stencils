module.exports = ->

  controller = @

  init = ->

    calculatePrice = ->

      price = {}

      number = 1

      isStencil = (type) -> typeof controller.stencil[type] is "string"

      if (isStencil "top") and isStencil "bottom" then number = 2

      configuration = controller.order.configurationObject

      totalApertures = controller.stencil.apertures

      fudicals = configuration.fudical.number

      size = configuration.stencil.height + configuration.stencil.width

      extraFudicals = fudicals - 8

      if extraFudicals > 0 then price.fudicals = extraFudicals * 0.98 * number

      stencilCategory = ->
        categories = [
          220 + 140
          270 + 220
          300 + 270
          400 + 300
          600 + 600
        ]

        if size > categories[4] then return 5

        for category of categories
          if size <= categories[category] then return category

      category = stencilCategory()
      category++

      baseApertures = category * 500 * number

      price.size = 65 * number

      for i in [1..category]
        l = 1

        if 2 < i < 5 then l = 4

        if i > 4 then l = 8

        price.size += 5 * l * number

      extraApertures = totalApertures - baseApertures

      if extraApertures > 0

        if 3000 < extraApertures <= 5000 then k = 0.0498
        else
          if extraApertures > 5000 then k = 0.03912
          else k = 0.05867

        price.extraApertures = extraApertures * k

      calculateTextPrice = (stencil) ->
        if not controller.order[stencil]? then return 0
        else
          text = controller.order[stencil].text
          symbols = (line.match /\S/g for line in text).join().length
          extra = symbols - 120
          if extra > 0 then return extra * 0.04
          else return 0

      price.text = (calculateTextPrice "top") + calculateTextPrice "bottom"

      console.log price

      (value for key, value of price).reduce (a, b) -> a + b

    controller.order.price = parseFloat calculatePrice().toFixed 2

  init()

  controller
