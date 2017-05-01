# Description
#   Sends messages to tree_planter
#
# Configuration:
#   HUBOT_TREE00           - source,destination,nickname
#   HUBOT_TREE01           - git@code.example.com:username/repo.git,http://www01.example.com:8080,prod-website
#
# Commands:
#   hubot plant <nickname> - deploys the default branch using the /deploy endpoint
#   hubot plant <branch name> of <nickname> - deploys the feature/new_stuff branch using the /gitlab endpoint
#   tree farm - displays a list of all known trees that can be planted
#
# Author:
#   Gene Liverman (genebean)

farm = []
for key, value of process.env
  if key.match(/\d+$/)
    valueparts          = value.split ","
    tree                = {}
    tree['env-var']     = key
    tree['source']      = valueparts[0]
    tree['destination'] = valueparts[1]
    tree['nickname']    = valueparts[2]
    farm.push tree


module.exports = (robot) ->
  robot.hear /tree farm/i, (msg) ->
    msg.send "Here's the farm's inventroy:"

    thefarm = ''
    for tree in farm
      thefarm += 'nickname    : ' + tree['nickname']    + '\n'
      thefarm += 'source      : ' + tree['source']      + '\n'
      thefarm += 'destination : ' + tree['destination'] + '\n'
      thefarm += 'env. var.   : ' + tree['env-var']     + '\n\n'

    msg.send thefarm

  robot.respond /plant (\w+)/i, (msg) ->
    nickname = msg.match[1]
    for tree in farm
      if tree['nickname'] is tree
        tree = tree['source'].split('/').pop().replace(/\.git/, '')
        repo = tree['source']
        url  = "#{tree['destination']}/deploy"
        dst  = url.replace('http://','').replace('https://','').split(/[/?#]/)[0].split(':')[0]
        data = JSON.stringify({
          tree_name: tree,
          repo_url: tree['source']
        })

        msg.send "Planting #{tree} on #{dst}..."
        msg.http(url)
        .header('Content-Type', 'application/json')
        .post(data) (err, res, body) ->
          if err
            res.send "Encountered an error :( #{err}"
            return

          if res.statusCode isnt 200
            res.send "Request didn't come back HTTP 200 :("
            return

          msg.send body
