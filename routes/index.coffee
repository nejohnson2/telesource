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
  console.log "************  Sending SMS  ************".grey
  console.log " "
  console.log req.query.message.white
  console.log " "
  console.log "***************************************".grey
  message = req.query.message
  command = "echo tmsis | sudo OpenBTSCLI | grep -v TMSI | awk '{print $2}' | grep -v '^$' | grep -E \"[0-9]+\""
  child = exec(command, (error, stdout, stderr) ->
    console.log "exec error: #{error}".red if error?
    list = stdout.split("\n")
    i = 0

    while i < list.length - 1
      unless list[i] is ""
        newCommand = "echo sendsms " + list[i] + " 101 " + message + " | sudo OpenBTSCLI"
        console.log newCommand.yellow
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
  command = "echo tmsis | sudo OpenBTSCLI | grep -v TMSI | awk '{print $2}' | grep -v '^$' | grep -E \"[0-9]+\""
  console.log command.yellow
  child = exec(command, (error, stdout, stderr) ->
    console.log "IMSI NUMBERS".grey
    res.send stdout
  )

#
#   GET /numbers
#
exports.numbers = (req, res) ->
  command = 'echo .dump dialdata_table | sqlite3 /var/lib/asterisk/sqlite3dir/sqlite3.db | grep VALUES | awk \'{print $4}\' | cut -d"\'" -f2,4'
  console.log command.yellow
  child = exec(command, (error, stdout, stderr) ->
    console.log "PHONE NUMBERS".grey
    res.send stdout
  )
  
#
#	GET /cellid
#
exports.cellid = (req, res) ->
  command = 'echo cellid | sudo OpenBTSCLI | grep -A 0 \'MNC\''
  console.log command.yellow
  child = exec(command, (error, stdout, stderr) ->
    console.log "CellID Information".grey
    res.send stdout
  )
  