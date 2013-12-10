var exec = require('child_process').exec;
/*
	GET /
*/
exports.main = function(req, res){
        res.render('main.html');
}

/*
	GET /input
*/
exports.input = function(req, res){
	
	console.log(req.query.message);

	var message = req.query.message;
    var command = "echo tmsis | sudo ./OpenBTSCLI | grep -v TMSI | awk '{print $2}' | grep -v '^$' | grep -E \"[0-9]+\"";
	
    var child = exec(command, function(error, stdout, stderr) {
	    
		if (error != null) {
			console.log('exec error: ' + error);
		}
		    
		var list = stdout.split('\n')
		
		for(var i=0; i<list.length-1; i++){
	        if(list[i] != ''){
	            var newCommand = "echo sendsms " + list[i] + " 0 " + message + " | sudo ./OpenBTSCLI";
	            
	            console.log(newCommand);
	            
	            var newChild = exec(newCommand, function(error, stdout,stderr) {
	                    if(error != null) {
	                            console.log('New Child exec error: ' + error);
	                    }                                        
	            });
	        }
		}
    });

	res.redirect('/');	
/* 	res.send("success"); */

}
/*
	GET /tmsis
*/
exports.tmsis = function(req, res){
    var command = "echo tmsis | sudo ./OpenBTSCLI | grep -v TMSI | awk '{print $2}' | grep -v '^$' | grep -E \"[0-9]+\"";
    console.log(command);
    
     var child = exec(command, function(error, stdout, stderr){
            console.log("IMSI NUMBERS");
            response.send(stdout);
    });
}