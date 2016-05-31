model = require "./../orderModel"
visits = require "./../../user/visit/visitModel"
mongoose = require "mongoose"
dateHelper = require "./../../../share/dateHelper"
mongoose.connect "mongodb://#{process.env.DB_IP}:27017/db"
date = dateHelper.$get()

randomN = (n) -> Math.floor Math.random() * n

dates = []

range = [0..10]

for i in range
  for j in range
    dates.push new Date 2016, i, j + 3, (randomN 12), (randomN 60), (randomN 60), (randomN 60)

sendingDates = dates

orderDates = dates

prices = (k for k in [10..100] by 20)

statuses = ["new", "accepted", "sent", "delivered", "rejected"]

created = []

visit = ip: "127.0.0.1"

success = ->
  console.log "fill"
  process.exit()

fail = (err) ->
  console.log "error", err
  process.exit()

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
      visit.date = date.format orderDates[randomN orderDates.length]
      visit.user = Math.random() >= 0.5
      created.push visits.create visit
    (Promise.all created).then success, fail
