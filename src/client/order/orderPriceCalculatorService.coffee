service = (listOfPrices) ->
  (order) ->
    price = {}
    stencil = {}
    number = 1
    price[key] = 0.00 for key in listOfPrices
    stencil[type] = order.apertures[type] > 0 for type in ["top", "bottom"]
    if stencil.top and stencil.bottom then number++
    configuration = order.configurationObject
    fudicals = order.specific.fudicals
    size = order.specific.dimenstions.height + order.specific.dimenstions.width
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
      if size <= categories[category] then return category for category of categories

    category = stencilCategory()
    category++

    price.size = 65.89 * number

    for i in [1..category]
      l = 1
      if 2 < i < 5 then l = 4
      if i > 4 then l = 8
      price.size += 5.021 * l * number

    baseApertures = category * 500

    calculateExtraAperturesPrice = (wich) ->
      if not stencil[wich] then return 0.00
      extraApertures = order.apertures[wich] - baseApertures
      if extraApertures > 0
        if 3000 < extraApertures <= 5000 then k = 0.0498
        else
          if extraApertures > 5000 then k = 0.03912
          else k = 0.05867
        return extraApertures * k
      else return 0.00

    price.apertures = (calculateExtraAperturesPrice "top") + calculateExtraAperturesPrice "bottom"

    calculateTextPrice = (wich) ->
      if not stencil[wich] then return 0.00
      else
        text = order[wich + "Text"]
        symbols = (line.match /\S/g for line in text).join().replace /\,/g, ""
        extra = symbols.length - 120
        return if extra > 0 then extra * 0.04 else 0.00

    price.text = (calculateTextPrice "top") + calculateTextPrice "bottom"

    if configuration.stencil.transitioning is "glued-in-frame"
      frame = 5.23
      if configuration.stencil.frame.size isnt "custom"
        if configuration.stencil.frame.clean then frame += 34.12
        else frame += 24.34
      price.glued = frame * number
    
    if configuration.stencil.impregnation then price.impregnation = 29.34 * number
    price.total = (value for key, value of price).reduce (a, b) -> a + b
    price[key] = parseFloat value.toFixed 2 for key, value of price
    console.log price
    price

service.$inject = ["listOfPrices"]

module.exports = service