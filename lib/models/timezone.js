'use strict';

var mongoose = require('mongoose'),
  Schema = mongoose.Schema;
    
// Schema
var TimezoneSchema = new Schema(
  {
    ty: Number, 
    l: { type: [Number], index: '2dsphere'},
    ts: [String]

  }
, { collection: 'timezone' });

mongoose.model('Timezone', TimezoneSchema);
