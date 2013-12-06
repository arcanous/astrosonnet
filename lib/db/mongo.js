'use strict';

var mongoose = require('mongoose');

exports.mongoose = mongoose;

// Configure for possible deployment
var uristring =
  process.env.MONGOLAB_URI ||
  process.env.MONGOHQ_URL ||
  'mongodb://nodejitsu_kbdaitch:rroe3fpevp709t870a7ilula13@ds045998.mongolab.com:45998/nodejitsu_kbdaitch_nodejitsudb9100787641';

var mongoOptions = { db: { safe: true } };

// Connect to Database
mongoose.connect(uristring, mongoOptions, function (err, res) {
  if (err) {
    console.log ('ERROR connecting to: ' + uristring + '. ' + err);
  } else {
    console.log ('Successfully connected to: ' + uristring);
  }
});
