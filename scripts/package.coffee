
module.exports = (robot) ->
  robot.respond /package me (.*)/i, (msg) ->
      msg.send "Not yet. I'm still learning how to package"
