// Generated by CoffeeScript 1.9.2
(function() {
  var colors;

  colors = require('colors');

  module.exports = {
    info: function(str) {
      return console.log(("[INFO] " + str).trim().green);
    },
    event: function(str) {
      return console.log(("[EVENT] " + str).trim().blue.bold);
    }
  };

}).call(this);
