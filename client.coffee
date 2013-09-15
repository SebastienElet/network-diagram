module.exports = (program) ->
  mtr = require('mtr').Mtr
  graphviz = require('graphviz')
  request = require('request')

  if !program.args.length then console.log 'Please add ip to trace'

  traces = []

  for ip in program.args
    console.log "Starting mtr on ip : #{ip}"
    trace = new mtr(ip)
    trace.on 'error', (err) ->
      console.log err
    trace.on 'hop', (hop) ->
      traces.push hop
    trace.on 'end', () ->
      traces = { "traces":traces }
      console.log "Send to server #{program.url}"
      request.post(program.url)
        .form(traces)

    trace.traceroute()
