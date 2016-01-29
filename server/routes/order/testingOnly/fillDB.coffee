model = require "./../orderModel"
visits = require "./../../user/visit/visitModel"
mongoose = require "mongoose"
mongoose.connect require "./../../../mongo"
dateHelper = require "./../../../share/dateHelper"
date = dateHelper.$get()

user = "56abcb72609838822e126371"

fake =
	user : user
	addressesObject :
		name : "test"
		user : user
		firm :
			country : "bulgaria"
			city : "romania"
			postcode : "100"
			address1 : "Str. Str1"
			address2 : "Str. Str2"
			firstname : "Ivo"
			lastname : "Stratev"
		invoice :
			country : "bulgaria"
			city : "romania"
			postcode : "100"
			address1 : "Str. Str1"
			address2 : "Str. Str2"
			firstname : "Ivo"
			lastname : "Stratev"
		delivery :
			country : "bulgaria"
			city : "romania"
			postcode : "100"
			address1 : "Str. Str1"
			address2 : "Str. Str2"
			firstname : "Ivo"
			lastname : "Stratev"
	configurationObject :
		name : "test"
		user : user
		text :
			position : "center-right"
			angle : "left"
			type : "engraved"
			side : "squeegee-side"
		stencil :
			transitioning : "glued-in-frame"
			tickness : "120 μm         ",
			type : "smd-stencil"
			height : 270
			width : 220
			size : "750 x 750"
	position :
			side : "squeegee-side"
			position : "like-layout-file"
			aligment : "landscape"
		fudical :
			marks : "engraved"
			side : "pcb-side"
	bottomText : ["bottom"]
	topText : ["top"]
	files :
		outline : "#{user}___F4OQGXL2___Border_Milling.pho"
		bottom : "#{user}___b1g4tZV8___PasteMask_Bottom.pho"
		top : "#{user}___es73xbvr___PasteMask_Top.pho"
	style :
		frame : true
		outline : false
		layout : false
		mode : "landscape-no"

randomN = (n) -> Math.floor Math.random() * n

dates = []

range = [0..3]

for i in range
  for j in range
    dates.push new Date 2016, i, j * 8, (randomN 12), (randomN 60), (randomN 60), (randomN 60)

sendingDates = dates

orderDates = dates

prices = (k for k in [10..100] by 20)

statuses = ["new", "accepted", "sent", "delivered", "rejected"]

created = []

fill = (order) ->
  new Promise (resolve, reject) ->
    model.create order, (err, doc) ->
      if not err? and doc?
        resolve()
      else reject err

add = (visit) ->
  new Promise (resolve, reject) ->
    visits.create visit, (err, doc) ->
      if not err? and doc?
        resolve()
      else reject err

for i in [0..99]
  order = JSON.parse JSON.stringify fake
  order.sendingDate = sendingDates[randomN sendingDates.length]
  order.orderDate = orderDates[randomN orderDates.length]
  order.price = prices[randomN prices.length]
  order.status = statuses[randomN statuses.length]
  created.push fill order
  visit =
    date: date.format orderDates[randomN orderDates.length]
    user: Math.random() >= 0.5
    ip: "ip"
  created.push add visit

Promise
  .all created
  .then (-> console.log "fill"), ((e)-> console.log "err", e)
