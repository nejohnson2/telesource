var ejs = require('ejs');
var express = require('express'),
	app = express.createServer();
	
app.configure(function(){
	app.set('port', process.env.PORT || 5000);
	
	app.set('view engine', 'ejs');
	app.set('views', __dirname + '/views');
	app.set('view options', {layout:true});
	app.register('html',require('ejs'));
	
	app.use(express.static(__dirname + '/public'));
	
    app.use(express.bodyParser());
    
    /**** Turn on some debugging tools ****/
    app.use(express.logger());
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
	
});

app.get('/', function(req, res) {
	res.render('main.html');
});

var port = process.env.PORT || 3000;
app.listen(port, function() {
  console.log("Listening on " + port);
});