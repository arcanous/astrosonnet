'use strict';

var mongoose = require('mongoose');

exports.mongoose = mongoose;

// Configure for possible deployment
var uristring;

if (process.env.NODE_ENV === "production") 
  uristring = process.env.MONGOLAB_URI || process.env.MONGOHQ_URL;
else
  uristring = 'mongodb://localhost/demo';

var mongoOptions = { db: { safe: true } };

// Connect to Database
mongoose.connect(uristring, mongoOptions, function (err, res) {
  if (err) {
    console.log ('ERROR connecting to: ' + uristring + '. ' + err);
  } else {
    console.log ('Successfully connected to: ' + uristring);
  }
});
