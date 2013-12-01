'use strict';
// add coffee-script feature
require('coffee-script');

var __config = global.__config = {};
global.__log = console.log;

var express = require('express'),
    http = require('http'),
    path = require('path');

var async = require('async');
var utils = require('./lib/utils');
var anthPack = require('anthpack');

var app = express();

var initTasks = [

	// Load Config
	function(callback) {
		// load configurations to global.__config
		__config = utils.loadConfigs();

		// Connect mongodb
		utils.connectDB(callback);
	},

	// Connect to Redis
	function(callback) {
		utils.connectRedis(callback);
	},

	// Init anthPack
	function(callback) {
		anthPack.config(__config.anthPack);
		callback();
	},

	function(callback) {

		// all environments
		app.set('port', process.env.PORT || __config.port || 3000);

		app.use(express.logger('dev'));

		app.use(express.cookieParser());
		app.use(express.bodyParser());
		app.use(express.methodOverride());
		app.use(app.router);

		// development only
		if (__config.debug) {
		  app.use(express.static(path.join(__dirname, '.tmp')));
		  app.use(express.static(path.join(__dirname, 'app')));
		  app.use(express.errorHandler());
		}
		// production or others env
		else {
		  app.use(express.favicon(path.join(__dirname, 'public/favicon.ico')));
		  app.use(express.static(path.join(__dirname, 'public')));
		}

		callback();

	},

	function(callback) {
		// load routes
		utils.loadRoutes(path.join(__dirname, './lib/api'), app);

		callback();
	}

];

// Finally, start server!
async.series(initTasks, function(err) {
	if(err) {
		throw err;
	}

	http.createServer(app).listen(app.get('port'), function () {
		// TODO: Print system info
		global.__log('Server listening on port %d in %s mode', app.get('port'), app.get('env'));
	});

});


