describe "emailTakenDirective", ->

  tested = require "./../isTakenDirective"

  RESTHelperService = undefined

  ngModel = $asyncValidators: {}

  beforeEach ->

    RESTHelperService = user: email: jasmine.createSpy()

    emailTakenDirective = tested RESTHelperService

    link = emailTakenDirective.link

    link {}, {}, {}, ngModel

  it "should resolve if email isn't taken", (done) ->

    RESTHelperService.user.email.and.callFake (email, cb) ->
      cb taken: false

    (ngModel.$asyncValidators["email-taken"] "not@taken").then done

  it "should reject if email is taken", (done) ->

    RESTHelperService.user.email.and.callFake (email, cb) ->
      cb taken: true

    (ngModel.$asyncValidators["email-taken"] "email@taken").then null, done
