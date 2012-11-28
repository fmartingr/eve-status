https = require 'https'
elementtree = require 'elementtree'

API_URL = 'https://api.eveonline.com/server/ServerStatus.xml.aspx/'
XML_PATH = 'result/'

https.get API_URL, (response) ->
	data = ''	
	response.on 'data', (chunk) ->
		data += chunk
	response.on 'end', ->
		tree = elementtree.parse data
		result =
			serverOpen: tree.findtext "#{XML_PATH}serverOpen"
			onlinePlayers: tree.findtext "#{XML_PATH}onlinePlayers"
			cachedUntil: tree.findtext "cachedUntil"
		console.log result
.on 'error', (error) ->
	console.log error.message
