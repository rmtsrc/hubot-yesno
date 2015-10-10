# Description:
#   Random yes or no with image from the yesno api
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot yes or no? - Random yes or no!
#
# Author:
#   sebflipper

module.exports = (robot) ->
  robot.respond /yes (or )?no(\?)?/i, (msg) ->
    msg.http('http://yesno.wtf/api')
      .get() (err, res, body) ->
        if res.statusCode != 200
          msg.send if Boolean(Math.floor(Math.random() * 2)) then 'Yes!' else 'No!'
        else
          object = JSON.parse(body)
          msg.send object.answer, object.image
