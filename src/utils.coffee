colors = require 'colors'
module.exports =
  info: (str) ->
    console.log "[INFO] #{str}".trim().green
  event: (str) ->
    console.log "[EVENT] #{str}".trim().blue.bold
