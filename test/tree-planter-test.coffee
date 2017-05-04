Helper = require('hubot-test-helper')
chai = require 'chai'

expect = chai.expect

helper = new Helper('../src/tree-planter.coffee')

describe 'tree-planter', ->
  beforeEach ->
    @room = helper.createRoom(httpd: false)

  afterEach ->
    @room.destroy()

  it 'hears tree farm', ->
    @room.user.say('bob', 'What do we have on the tree farm today?').then =>
      expect(@room.messages).to.eql [
        ['bob', 'What do we have on the tree farm today?']
        ['hubot', "Here's the farm's inventroy:"]
        ['hubot', "nickname    : tree-planter-via-http\n
source      : https://github.com/genebean/tree-planter.git\n
destination : http://127.0.0.1:8081\n
env. var.   : HUBOT_TREE01\n\nnickname    : tree-planter-via-ssh\n
source      : git@github.com:genebean/tree-planter.git\n
destination : http://127.0.0.1:8081\n
env. var.   : HUBOT_TREE02\n\n"]
      ]

  # it 'responds to plant tree-planter-via-http', ->
  #   @room.user.say('alice', '@hubot plant tree-planter-via-http').then =>
  #     console.log @room.messages
  #     expect(@room.messages).to.include [
  #       ['alice', '@hubot plant tree-planter-via-http']
  #       ['hubot', 'Planting tree-planter on app02.example.com...']
  #     ]
