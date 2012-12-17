EVE-Status 0.3.0
================

This is a simple EVE-Online server monitor written in Node.

![Eve-Status](http://cdn.fmartingr.com/github/eve-status.png)

It was initially though to be my first script with web sockets, but since the EVE API caches the petition -and it is **really** useless to have a realtime server status monitor for this kind of things- I just decided to finish this script using  a GET AJAX petition with a timeout based on when the EVE API refreshes the status.

**The EVE online API:** [Documentation here](http://wiki.eveonline.com/en/wiki/EVE_API_Misc_Server_Status)

### Using the script in local (really?!)

```
git clone git@github.com:fmartingr/eve-status.git]]
cd eve-status
npm install
node app.js
```

Head to `localhost:3000` and watch the "magic"!

### Demo

[Link to dotCloud demo](http://evestatus-fmartingr.dotcloud.com/)
