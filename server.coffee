express = require('express')
fs = require('fs')
app = express()
app.use(express.bodyParser())
app.engine('jade', require('jade').__express)
app.set "views", __dirname + "/views"
app.use express.static(__dirname + "/public/")

graphviz = require('graphviz')
graph = graphviz.digraph('G')

app.get '/', (req, res) ->
  res.render('index.jade')
app.post '/trace', (req, res) ->

  lastHop = null
  if !req.body.traces
    console.warn 'No trace found'

  for hop in req.body.traces
    console.log hop.ip
    if hop.ip is null then continue
    if hop.ip is undefined then continue
    node = graph.addNode(hop.ip)

    if lastHop
      console.log "Add edge"
      graph.addEdge(lastHop, hop.ip)

    lastHop = node
     
  fs.writeFile(
    __dirname + '/public/graph.dot',
    graph.to_dot()
  )
  graph.output('png', __dirname + '/public/graph.png')
  res.send 200

module.exports = app
