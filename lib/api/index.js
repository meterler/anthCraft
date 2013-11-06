'use strict';

module.exports = function(app) {
	app.get('/api/awesomeThings', function(req, res) {
	  res.json([
	    'HTML5 Boilerplate',
	    'AngularJS',
	    'Karma',
	    'Express'
	  ]);
	});
};
