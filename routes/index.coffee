exec = require("child_process").exec

#
#    GET /
#
exports.main = (req, res) ->
  res.render "main.html"

#
#   GET /input
#
exports.input = (req, res) ->
  console.log req.query.message
  message = req.query.message
  command = "echo tmsis | sudo ./OpenBTSCLI | grep -v TMSI | awk '{print $2}' | grep -v '^$' | grep -E \"[0-9]+\""
  child = exec(command, (error, stdout, stderr) ->
    console.log "exec error: #{error}" if error?
    list = stdout.split("\n")
    i = 0

    while i < list.length - 1
      unless list[i] is ""
        newCommand = "echo sendsms " + list[i] + " 0 " + message + " | sudo ./OpenBTSCLI"
        console.log newCommand
        newChild = exec(newCommand, (error, stdout, stderr) ->
          console.log "New Child exec error: " + error  if error?
        )
      i++
  )
  res.redirect "/"

#
#   GET /tmsis
#
exports.tmsis = (req, res) ->
  command = "echo tmsis | sudo ./OpenBTSCLI | grep -v TMSI | awk '{print $2}' | grep -v '^$' | grep -E \"[0-9]+\""
  console.log command
  child = exec(command, (error, stdout, stderr) ->
    console.log "IMSI NUMBERS"
    res.send stdout
  )