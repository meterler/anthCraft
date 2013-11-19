'use strict';
// add coffee-script feature
require('coffee-script');

var __config = global.__config = {};

var express = require('express'),
    http = require('http'),
    path = require('path');

var utils = require('./lib/utils');

var app = express();

// load configurations to global.__config
utils.loadConfigs();
utils.connectDB();

// all environments
app.set('port', process.env.PORT || __config.port || 3000);

app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);

// development only
if ('development' === app.get('env')) {
  app.use(express.static(path.join(__dirname, '.tmp')));
  app.use(express.static(path.join(__dirname, 'app')));
  app.use(express.errorHandler());
}
// production or others env
else {
  app.use(express.favicon(path.join(__dirname, 'public/favicon.ico')));
  app.use(express.static(path.join(__dirname, 'public')));
}

// load routes
utils.loadRoutes(path.join(__dirname, './lib/api'), app);

http.createServer(app).listen(app.get('port'), function () {
  console.log('Express server listening on port %d in %s mode', app.get('port'), app.get('env'));
});

