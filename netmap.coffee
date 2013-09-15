program = require('commander')
program
  .version('0.0.1')
  .option('-c, --client', 'start a netmap client')
  .option('-s, --server', 'start a netmap server')
  .option('-p, --port <port>', 'listen port for server', 4000)
  .option(
    '-u, --url <url>',
    'server url to push datas',
    'http://localhost:4000/trace'
  )
  .parse(process.argv)

if program.server
  server = require('./server.coffee')
  server.listen(program.port)
  console.log "Server started on port #{program.port}"

if program.client
  client = require('./client.coffee')(program)
