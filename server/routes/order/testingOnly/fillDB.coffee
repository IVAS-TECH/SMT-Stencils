model = require "./../orderModel"
visits = require "./../../user/visit/visitModel"
mongoose = require "mongoose"
mongoose.connect require "./../../../mongo"
dateHelper = require "./../../../share/dateHelper"
date = dateHelper.$get()

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

model.find {}, (err, doc) ->
	if not err?
		fake = doc[0]
		fake._id = undefined
		for i in [0..99]
		  order = JSON.parse JSON.stringify fake
		  order.sendingDate = sendingDates[randomN sendingDates.length]
		  order.orderDate = orderDates[randomN orderDates.length]
		  order.price = prices[randomN prices.length]
		  order.status = statuses[randomN statuses.length]
		  created.push model.create order
		  created.push visits.create
				date: date.format orderDates[randomN orderDates.length]
				user: Math.random() >= 0.5
				ip: "ip"
		Promise
		  .all created
		  .then (-> console.log "fill"), ((e)-> console.log "err", e)
