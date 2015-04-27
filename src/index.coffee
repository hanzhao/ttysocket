readline = require 'readline'
net = require 'net'

port = process.env['port'] || 34123
hostname = process.env['hostname'] || '127.0.0.1'

### Readline Loop ###
rl = readline.createInterface
  input: process.stdin
  output: process.stdout

### Socket Server ###
net.createServer (socket) ->
  rl.on 'line', (line) ->
    socket.write resolve line
    console.log "Response for '#{line}' has written to socket."
.listen port, hostname, ->
  console.log "Server listening on #{hostname}:#{port}."

### Resolve messages which needs to implement ###
resolve = (line) ->
  line + "\n"
