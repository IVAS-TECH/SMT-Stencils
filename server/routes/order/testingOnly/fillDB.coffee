model = require "./../orderModel"
mongoose = require "mongoose"
mongoose.connect require "./../../../mongo"

fill = (order) ->
  new Promise (resolve, reject) ->
    model.create order, (err, doc) ->
      if not err? and doc?
        resolve()
      else reject err

fake = {
	"user" : "566483d4dfdf6681796776a0",
	"addressesObject" : {
		"name" : "test",
		"user" : "566483d4dfdf6681796776a0",
		"firm" : {
			"country" : "bulgaria",
			"city" : "romania",
			"postcode" : "100",
			"address1" : "Str. Str1",
			"address2" : "Str. Str2",
			"firstname" : "Ivo",
			"lastname" : "Stratev"
		},
		"invoice" : {
			"country" : "bulgaria",
			"city" : "romania",
			"postcode" : "100",
			"address1" : "Str. Str1",
			"address2" : "Str. Str2",
			"firstname" : "Ivo",
			"lastname" : "Stratev"
		},
		"delivery" : {
			"country" : "bulgaria",
			"city" : "romania",
			"postcode" : "100",
			"address1" : "Str. Str1",
			"address2" : "Str. Str2",
			"firstname" : "Ivo",
			"lastname" : "Stratev"
		}
	},
	"configurationObject" : {
		"name" : "test",
		"user" : "566483d4dfdf6681796776a0",
		"text" : {
			"position" : "center-right",
			"angle" : "left",
			"type" : "engraved",
			"side" : "squeegee-side"
		},
		"stencil" : {
			"transitioning" : "glued-in-frame",
			"tickness" : "120 μm         ",
			"type" : "smd-stencil",
			"size" : "750 x 750"
		},
		"position" : {
			"side" : "squeegee-side",
			"position" : "like-layout-file",
			"aligment" : "landscape"
		},
		"fudical" : {
			"marks" : "engraved",
			"side" : "pcb-side"
		}
	},
	"bottomText" : [
		"bottom"
	],
	"topText" : [
		"top"
	],
	"files" : {
		"outline" : "566483d4dfdf6681796776a0___F4OQGXL2___Border_Milling.pho",
		"bottom" : "566483d4dfdf6681796776a0___b1g4tZV8___PasteMask_Bottom.pho",
		"top" : "566483d4dfdf6681796776a0___es73xbvr___PasteMask_Top.pho"
	},
	"style" : {
		"frame" : true,
		"outline" : false,
		"layout" : false,
		"mode" : "landscape-no"
	}
}

dates = []

range = [1..3]

for i in range
  for j in range
    dates.push new Date 2016, i, j * 8

sendingDates = dates

orderDates = dates

prices = (k for k in [10..100] by 20)

statuses = ["new", "accepted", "send", "delivered", "rejected"]

created = []

for i in [0..29]
  order = JSON.parse JSON.stringify fake
  order.sendingDate = sendingDates[Math.floor Math.random() * sendingDates.length]
  order.orderDate = orderDates[Math.floor Math.random() * orderDates.length]
  order.price = prices[Math.floor Math.random() * prices.length]
  order.status = statuses[Math.floor Math.random() * statuses.length]
  created.push fill order

Promise
  .all created
  .then (-> console.log "fill"), ((e)-> console.log "err", e)
