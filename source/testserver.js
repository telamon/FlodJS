// Quick node.js test serving app to enable html5 xhr and file loader requests.

var http = require('http');
var fs = require('fs');
var path = require('path');
var server = http.createServer(function(req,res){
  function sendFile(filename,mime){
      mime = mime || 'text/html';
      res.writeHead(200, {'Content-Type': mime, 'Connection': 'close'});
      fs.createReadStream( path.normalize(path.join(__dirname,'./', filename)), {
        'flags': 'r',
        'encoding': 'binary',
        'mode': 0666,
        'bufferSize': 4 * 1024
      }).addListener("data", function(chunk){
        res.write(chunk, 'binary');
      }).addListener("end",function() {
        res.end();
      });
  }

  if(req.url == '/'){
    req.url = '/index.htm';
    
  }
  var mime = null;
  if(req.url.match(/\.js$/)){
    mime = 'text/javascript';
  }else if(req.url.match(/\.html?$/)){
    mime = 'text/html';
  }
  sendFile(req.url,mime);
});
process.on('uncaughtException', function (err) {
  console.log('Caught exception: ' + err);
});
server.listen(3000);
