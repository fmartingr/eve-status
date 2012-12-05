EVE-Status 0.3.0
================

This is a simple EVE-Online server monitor written in Node.

It was initially though to be my first script with web sockets, but since the EVE API caches the petition -and it is **really** useless to have a realtime server status monitor for this kind of things- I just decided to finish this script using GET AJAX petition with a timeout based on when the EVE refreshes the status.

### The EVE online API

[Documentation here](http://wiki.eveonline.com/en/wiki/EVE_API_Misc_Server_Status)

### Using the script in local (really?!)

```
git clone git@github.com:fmartingr/eve-status.git
cd eve-status
npm install
node app.js
```

Head to `localhost:3000` and watch the "magic"!

### NOTE
Since neither AppFog nor dotCloud support https petitions, I can't have a working demo online!

[Link to dotCloud demo](http://evestatus-fmartingr.dotcloud.com/) | [Link to appFog demo](http://eve-status.eu01.aws.af.cm/) (I will probably shut down this one...)