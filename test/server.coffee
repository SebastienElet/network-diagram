app = require('../server.coffee')
request = require 'supertest'

describe 'Server', ->
  it 'should serve a page on /', (done) ->
    request(app)
      .get("/")
      .send({})
      .expect(200, {}, done)

describe 'Server push', ->
  it 'should accept a trace', ->
    request(app)
      .post("/traces")
      .expect(200)
