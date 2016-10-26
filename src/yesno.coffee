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
#   hubot yes - Random yes image
#   hubot no - Random no image
#   hubot maybe - Random maybe image
#
# Author:
#   sebflipper

module.exports = (robot) ->
  api = 'https://yesno.wtf/api'

  robot.respond /yes (or )?no(\?)?/i, (msg) ->
    msg.http(api)
      .get() (err, res, body) ->
        if res.statusCode != 200
          msg.send if Boolean(Math.floor(Math.random() * 2)) then 'Yes!' else 'No!'
        else
          object = JSON.parse(body)
          msg.send object.answer, object.image

  robot.respond /yes(\!)?/i, (msg) ->
    msg.http(api+'?force=yes')
    .get() (err, res, body) ->
      if res.statusCode != 200
        msg.send 'Yes!'
      else
        object = JSON.parse(body)
        msg.send object.answer, object.image

  robot.respond /no(\!)?/i, (msg) ->
    msg.http(api+'?force=no')
    .get() (err, res, body) ->
      if res.statusCode != 200
        msg.send 'No!'
      else
        object = JSON.parse(body)
        msg.send object.answer, object.image

  robot.respond /maybe(\!)?/i, (msg) ->
    msg.http(api+'?force=maybe')
    .get() (err, res, body) ->
      if res.statusCode != 200
        msg.send 'Maybe!'
      else
        object = JSON.parse(body)
        msg.send object.answer, object.image
