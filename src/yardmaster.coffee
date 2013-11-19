# Description:
#   Changes the branch on your jenkins instance remotely
#
# Dependencies:
#   Nope
#
# Configuration:
#   HUBOT_JENKINS_URL
#   HUBOT_JENKINS_USER
#   HUBOT_JENKINS_USER_API_KEY - Not your password. Find at "{HUBOT_JENKINS_URL}/{HUBOT_JENKINS_USER}/configure" 
#
# Commands:
#   hubot switch|change JOB to BRANCH - Change JOB to BRANCH
#   hubot (show )current branch for JOB - Shows current branch for JOB
# 
# Auther: 
#   hacklanta

module.exports = (robot) ->

  jenkinsURL = process.env.JENKINS_URL
  jenkinsUser = process.env.HUBOT_JENKINS_USER
  jenkinsUserAPIKey = process.env.HUBOT_JENKINS_USER_API_KEY
  
  robot.hear /(switch|change) (.+) to (.+)/i, (msg) ->
    job = msg.match[2]
    branch = msg.match[3]

    robot.http("#{jenkinsURL}/job/#{job}/config.xml")
      .auth("#{jenkinsUser}", "#{jenkinsUserAPIKey}")
      .get() (err, res, body) ->
        if err
          msg.send "Encountered an error :( #{err}"
          return
        else
          config = body.replace /\<name\>.*\<\/name\>/g, "<name>#{branch}</name>"   
          
          robot.http("#{jenkinsURL}/job/#{job}/config.xml")
            .auth("#{jenkinsUser}", "#{jenkinsUserAPIKey}")
            .post(config) (err, res, body) ->
              if err
                msg.send "Encountered an error :( #{err}"
                return
              else if res.statusCode is 200
                msg.send "#{job} updated to use brach #{branch}"
              else
                msg.send "something went wrong :(" 
                return
  
  robot.hear /(show\s)?current branch for (.+)/i, (msg) ->
    job = msg.match[2]
    
    robot.http("#{jenkinsURL}/job/#{job}/config.xml")
      .auth("#{jenkinsUser}", "#{jenkinsUserAPIKey}")
      .get() (err, res, body) ->
        if err
          msg.send "Encountered an error :( #{err}"
          return
        else      
          config = /<name>(.*)<\/name>/g.exec body
          msg.send("current branch is #{config[1]}")
          return
          