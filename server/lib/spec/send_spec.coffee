describe "send", ->

  res = sendSpy = statusSpy = send = undefined

  before ->

    send = require "./../send"

    sendSpy = sinon.spy()

    res =
        status: (stat) ->
          send: sendSpy

    statusSpy = sinon.spy res, "status"

  after -> statusSpy.restore()

  it "sets second arg: obj to {} if none was passed and sets status to 200: 'ok'", ->

    send res

    expect(statusSpy).to.have.been.calledWith 200

    expect(sendSpy).to.have.been.calledWith {}

  it "sets status to 200: 'ok'", ->

    what = test: 9

    send res, what

    expect(statusSpy).to.have.been.calledWith 200

    expect(sendSpy).to.have.been.calledWith what
