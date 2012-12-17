https = require 'https'
elementtree = require 'elementtree'
moment = require 'moment'
express = require 'express'
url = require 'url'
app = express()

DEBUG = true

API_URL = 'https://api.eveonline.com/server/ServerStatus.xml.aspx/'
XML_PATH = 'result/'

LAST_INFO = ''

####################################################
# DAEMON
####################################################

###
# Calculate the seconds from now to a given date
###
calculateTimeout = (_until, _untilFormat='YYYY-MM-DD HH:mm:ss') ->
	from = moment().unix()
	to = moment(_until, _untilFormat).unix()
	range = parseInt(to - from)

###
# Calculate and create a timeout for the next data check
###
createTimeout = ->
	# Calculate when cache expires
	range = calculateTimeout LAST_INFO.cachedUntil
	range += 1 # Adding one second just in case

	# If for any reason range is less than zero use 2 minutes as fallback timeout
	if range <= 0
		range = 120

	# Set timeout
	setTimeout ->
		checkStatus()
	, range*1000
	console.log "Setting timeout for next check: #{range} seconds" if DEBUG

###
# Make a petition to the EVE Online API and get the data
###
checkStatus = ->
	requestOptions =
		host: url.parse(API_URL).host
		path: url.parse(API_URL).path
		port: 443
		method: 'GET'
	https.request requestOptions, (response) ->
		data = ''
		response.on 'data', (chunk) ->
			data += chunk
		response.on 'end', ->
			tree = elementtree.parse data
			result =
				serverOpen: Boolean tree.findtext "#{XML_PATH}serverOpen"
				onlinePlayers: parseInt tree.findtext "#{XML_PATH}onlinePlayers"
				cachedUntil: moment(tree.findtext("cachedUntil"), "YYYY-MM-DD HH:mm:ss")
					.add('h', 1)
					.format("YYYY-MM-DD HH:mm:ss")
			LAST_INFO = result
			createTimeout()
	.on 'error', (error) ->
		createTimeout()
		console.log error.message
	.end()

# Initial check
checkStatus()


####################################################
# SITE
####################################################

# Status request
app.get '/status', (request, response) ->
	data = LAST_INFO
	data.timeout = calculateTimeout(LAST_INFO.cachedUntil) + 2 # +2 Correction (+1 from before, +1 for this)
	response.send data
	response.end()

# If debug is enabled, we can force a status check (CLIENTS WONT BE UPDATED)
if DEBUG
	app.get '/force_check', (request, response) ->
		checkStatus()
		response.end()

# Static HTML
app.configure ->
    app.use express.static(__dirname + '/public')

# Start server (AppFog)
app.listen process.env.VCAP_APP_PORT || 8080
