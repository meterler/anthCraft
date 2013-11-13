'use strict';

var fileUtil = require('./fileUtil.js');

exports.loadRoutes = function(routePath, app) {
	fileUtil.traverseFolderSync(routePath, /^[._]/, function(isErr, file) {
		if(isErr) {
			console.log('Error: loading route file ', file);
			throw 'Load routes error!';
		}
		require(file)(app);
	});
};

exports.loadConfigs = function() {
	var configType = process.env.NODE_ENV;
	global.__config = require('../config.' + configType);

	return global.__config;
};
