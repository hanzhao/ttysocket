net = require 'net'
minimist = require 'minimist'
serialport = require 'serialport'
SerialPort = serialport.SerialPort

{info, event} = require './utils'

help = ->
  console.log """
    usage: ttysocket [--help] --host SERVER_ADDR --port SERVER_PORT TTY_ADDR

    optional arguments:
      --help                    show this help message and exit
      --host SERVER_ADDR        server address
      --port SERVER_PORT        server port
  """

return help() if process.argv.length < 3
args = minimist process.argv.slice(2)
return help() if args.help?
port = args.port || 14580
host = args.host || 'hangzhou.aprs2.net'
tty = args._[0]
return help() unless tty?

### SerialPort Readline Loop ###
#sp = new SerialPort tty,
#  parser: serialport.parsers.readline "\n"
sp = process.stdin

### Socket Connection ###
client = net.createConnection port, host, ->
  event "Connected to #{host}:#{port}"
client.on 'data', (data) ->
  data = data.toString()
  ### Filter ping data ###
  info data if data.indexOf('ping') isnt data.length - 6
client.on 'end', ->
  event "Disconnected to #{host}:#{port}"

### Write data to remote server ###
sp.on 'data', (line) ->
  line = line.toString()
  client.write resolve line
  event "Response has written to socket."

### Resolve messages which needs to implement ###
resolve = (line) ->
  line + "\n"
