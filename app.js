// Generated by CoffeeScript 1.3.3
(function() {
  var API_URL, XML_PATH, elementtree, https;

  https = require('https');

  elementtree = require('elementtree');

  API_URL = 'https://api.eveonline.com/server/ServerStatus.xml.aspx/';

  XML_PATH = 'result/';

  https.get(API_URL, function(response) {
    var data;
    data = '';
    response.on('data', function(chunk) {
      return data += chunk;
    });
    return response.on('end', function() {
      var result, tree;
      tree = elementtree.parse(data);
      result = {
        serverOpen: tree.findtext("" + XML_PATH + "serverOpen"),
        onlinePlayers: tree.findtext("" + XML_PATH + "onlinePlayers"),
        cachedUntil: tree.findtext("cachedUntil")
      };
      return console.log(result);
    });
  }).on('error', function(error) {
    return console.log(error.message);
  });

}).call(this);