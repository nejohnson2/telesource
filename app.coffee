ejs = require "ejs"
partials = require "express-partials"
express = require "express"
app = express()
routes = require "./routes/index"
colors = require "colors"

app.configure ->
  app.use partials()
  app.engine "html", require("ejs").renderFile #renders .ejs as html
  app.set "views", __dirname + "/views"
  app.use express.static(__dirname + "/public")
  app.use express.bodyParser() #deals with incoming request objects
  app.use express.methodOverride()
  
  # Turn on some debugging tools
  app.use express.logger() # sends messages into the terminal
  app.use express.errorHandler( #dumpExceptions - directs exceptions to stderr - showStack - generate HTML for an exception å
    dumpExceptions: true
    showStack: true
  )

app.get "/", routes.main
app.get "/input", routes.input
app.get "/tmsis", routes.tmsis
app.get "/numbers", routes.numbers
app.get "/cellid", routes.cellid

port = process.env.PORT or 5000
app.listen port, ->
  console.log "Listening on " + port