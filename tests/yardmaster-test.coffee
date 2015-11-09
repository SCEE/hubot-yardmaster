Helper = require('hubot-test-helper')
chai = require('chai')

nock = require 'nock'

chai.Assertion.includeStack = true
chai.config.truncateThreshold = 0

expect = chai.expect
assert = chai.assert

helper = new Helper('./../src/yardmaster.coffee')

describe 'yardmaster', ->
  room = null

  beforeEach ->
    room = helper.createRoom()
    do nock.disableNetConnect

    nock("#{process.env.HUBOT_JENKINS_URL}")
     .get("/api/json")
     .reply 200, {
       jobs : [
         {
           "name": "Test1",
           "url" : "http://jenkins.internal.website.com/job/Test1",
           "color" : "blue"
         },
         {
           "name": "Test2",
           "url" : "http://jenkins.internal.website.com/job/Test2",
           "color": "yellow"
         },
         {
           "name": "Test3",
           "url" : "http://jenkins.internal.website.com/job/Test3",
           "color": "red"
         }

       ]
     }

  afterEach ->
    room.destroy()
    nock.cleanAll()

  context 'user wants to list the job' , ->
    beforeEach (done) ->
      room.user.say 'jay', 'hubot list jobs'
      setTimeout done, 100

    it 'should list the jobs on the server', ->
      expect(room.messages).to.eql([
        ['jay', 'hubot list jobs']
        ['hubot', "Here are the jobs\nTest1 is PASSING: http://jenkins.internal.website.com/job/Test1\nTest2 is FAILING: http://jenkins.internal.website.com/job/Test2\nTest3 is FAILING: http://jenkins.internal.website.com/job/Test3\n"]
      ])


