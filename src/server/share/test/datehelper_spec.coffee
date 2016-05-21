describe "dateHelper", ->
    dateHelper = dateObject = dateString = clock = service = undefined

    beforeEach ->
        dateHelper = require "./../dateHelper"
        dateObject = new Date 2012, 8, 15
        dateString = "15/9/2012"
        clock = sinon.useFakeTimers dateObject.getTime()
        service = dateHelper.$get()

    it "should format Date object by turning it into String", ->
        (expect dateHelper.formater() dateObject).to.equal dateString

    it "should parse Date String into Date object", ->
        (expect dateHelper.parser() dateString).to.eql dateObject

    it "passing the result from one method to the other shoudn't hvae any efect", ->
        (expect dateHelper.parser() dateHelper.formater() dateObject).to.eql dateObject
        (expect dateHelper.formater() dateHelper.parser() dateString).to.equal dateString

    it "should use current date if formater function has been called with no date object", ->
        (expect dateHelper.formater()()).to.equal dateString

    describe "dateHelper.$get()", ->
        it "calling $get() should create a dateHelperService (exactly the same as if Angular created the Service from a Provider) wich acts the same in formating/parsing as using *-ers", ->
            (expect service.format dateObject).to.equal dateString
            (expect service.parse dateString).to.eql dateObject
            (expect service.parse service.format dateObject).to.eql dateObject
            (expect service.format service.parse dateString).to.equal dateString
            (expect service.format()).to.equal dateString

        it "should create a new Date instance with cureent date when calling compatible without argument", ->
            (expect service.compatible()).to.eql dateObject

        it "should remove hour, minutes, seconds and miliseconds from Date object when calling compatible", ->
            (expect service.compatible new Date 2012, 8, 15, 2, 30).to.eql dateObject

        describe "dateHelper.$get().iterator(dateStart, dateEnd)", ->
            dateEnd = iterator = undefined

            beforeEach ->
                dateEnd = new Date 2012, 8, 16
                iterator = service.iterator dateObject, dateEnd

            it "calling iterator(dateStart, dateEnd) should create forward iterator for Date base range [dateStart - 1, dateEnd]", ->
                (expect iterator.value).to.eql new Date 2012, 8, 14

            it "should increase value with one day when next is called", ->
                iterator.next()
                (expect iterator.value).to.eql dateObject

            it "should stop changing .value when endDate is reached", ->
                iterator.next()
                (expect iterator.next()).to.be.true
                (expect iterator.value).to.eql dateEnd
                iterator.next()
                (expect iterator.value).to.eql dateEnd
