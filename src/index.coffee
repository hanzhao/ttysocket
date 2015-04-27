readline = require 'readline'
net = require 'net'
serialport = require 'serialport'
SerialPort = serialport.SerialPort

port = process.env['port'] || 34123
hostname = process.env['hostname'] || '127.0.0.1'

# Read tty info
rl = readline.createInterface
  input: process.stdin
  output: process.stdout
rl.question 'Which tty?(eg. /dev/tty-usbserial1) ', (tty) ->

  ### SerialPort Readline Loop ###
  sp = new SerialPort tty,
    parser: serialport.parsers.readline "\n"

  ### Socket Server ###
  net.createServer (socket) ->
    sp.on 'data', (line) ->
      socket.write resolve line
      console.log "Response for '#{line}' has written to socket."
  .listen port, hostname, ->
    console.log "Server listening on #{hostname}:#{port}."

  ### Resolve messages which needs to implement ###
  resolve = (line) ->
    line + "\n"
