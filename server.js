'use strict';
// add coffee-script feature
require('coffee-script/register');

var __config = global.__config = {};
global.__log = console.log;

var express = require('express'),
    http = require('http'),
    path = require('path');

var async = require('async');
var log4js = require('log4js');
var utils = require('./lib/utils');
var anthPack = require('anthpack');
var MemcachedStore = require('connect-memcached')(express)

var app = express();

var initTasks = {
	get_config: function(cb) {
		__config = utils.loadConfigs();
		cb(null, __config);
	},

	connect_mongodb: [ 'init_logger', function(cb) {
		utils.connectDB(cb);
	}],

	init_logger: [ 'get_config', function(cb) {
		log4js.configure(__config.log4js);
		global.__logger = log4js.getLogger('master');
		global.__log = function() {
			__logger.info.apply(__logger, arguments)
		}
		cb(null);
	}],

	// Disable Redis service
	// connect_redis: [ 'init_logger', function(cb) {
	// 	utils.connectRedis(cb);
	// }],

	init_anthpack: [ 'init_logger', function(cb) {
		anthPack.config(__config.anthPack, log4js.getLogger('anthpack'));
		cb();
	}],

	config_server: [ 'init_logger', function(cb) {
		// all environments
		app.set('port', process.env.PORT || __config.port || 3000);

		if (__config.debug) {
			app.use(express.logger('dev'));
		}

		app.use(express.cookieParser());
		app.use(express.cookieSession({
			secret: "anthcraft",
			// Session keep 1h alive
			cookie: { maxAge: 60 * 60 * 1000 },
			store: new MemcachedStore(__config.memcached)
		}));

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

		cb();

	}],

	load_routes: [ 'init_logger', 'connect_mongodb', 'config_server', function(cb) {
		// load routes
		utils.loadRoutes(path.join(__dirname, './lib/api'), app);

		cb();
	}]
}

async.auto(initTasks, function(err) {
	if(err) {
		throw err;
	}
	http.createServer(app).listen(app.get('port'), __config.host, function () {
		// TODO: Print system info
		global.__log('Server listening on port %d in %s mode', app.get('port'), app.get('env'));
	});
});
