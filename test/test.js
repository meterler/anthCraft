require('coffee-script');
var express = require('express'),
    restful = require('node-restful'),
    mongoose = restful.mongoose;
var app = express();

app.use(express.bodyParser());
app.use(express.query());

mongoose.connect('mongodb://root:anthcraft@ds053958.mongolab.com:53958/anthcraft');

var ThemeModel = require('./models/Theme.coffee');
var Resource = app.resource = restful.model('resource', mongoose.Schema({
    wallpaper: 'string'
  }))
  .methods(['get', 'post', 'put', 'delete']);

Resource.register(app, '/resources');
ThemeModel.register(app, '/api/themes');

app.listen(3000);

