'use strict';

var mongoose = require('mongoose'),
    Timezone = mongoose.model('Timezone'),
    async = require('async');

var Fiber = require('fibers');
var Future = require('fibers/future');

var swisseph = require('swisseph');
var Planets = [
  swisseph.SE_SUN,
  swisseph.SE_MOON,
  swisseph.SE_MERCURY,
  swisseph.SE_VENUS,
  swisseph.SE_MARS,
  swisseph.SE_JUPITER,
  swisseph.SE_SATURN,
  swisseph.SE_TRUE_NODE
];

exports.timezone = function(req, res) {
  Fiber(function(){
    var response = timezoneHelper(req.body).wait();
    console.log(response);
    res.send(response);
  }).run();

  // Get a future that resolves to the entry from the database for given query
  function fetchTimezoneFromDB(query) {
    var future = new Future();

    Timezone.findOne(query, function (err, data) {
      if (err || (!data)) {
        console.log("Error fetching timezone for (" + coordinates.longitude + ", " +  coordinates.latitude + "): " + err);
        future.return(null);
      }
      
      if (data["ts"][0] && data["ts"][1] == "type=multipolygon")
        future.return(data["ts"][0].substring(5));
    });

    return future;
  }

  function timezoneHelper(coordinates) {
    var future = new Future();

    var query = { 
        l: { 
          $geoIntersects : {
            $geometry : {
              type : 'Point' ,
                 coordinates : [coordinates.longitude, coordinates.latitude]
      } } } 
    };

    var timezone = fetchTimezoneFromDB(query).wait();
    future.return({tzid: (timezone || "America/Los_Angeles")});

    return future;
  }
}

exports.chart = function(req, res) {
  return res.send(chartHelper(req.body));
  
  function chartHelper(birthData) {
    console.dir(birthData)
    var date, flag;
    var result = {};
    
    date = {
      year: birthData.year,
      month: birthData.month,
      day: birthData.day,
      hour: birthData.hour,
      minute: birthData.minute,
      second: birthData.second,
      timezone: birthData.timezone
    };
    swisseph.swe_set_topo(birthData.longitude, birthData.latitude, birthData.altitude);
    flag = swisseph.SEFLG_SPEED | swisseph.SEFLG_SIDEREAL | swisseph.SEFLG_SWIEPH;
    swisseph.swe_set_sid_mode(swisseph.SE_SIDM_LAHIRI, 0, 0);
    
    swisseph.swe_set_ephe_path('eph/');

    swisseph.swe_utc_time_zone(date.year, date.month, date.day, date.hour, date.minute, date.second, date.timezone, function(data) {
      var julianDay, julianDayUT;
      julianDay = swisseph.swe_utc_to_jd(data.year, data.month, data.day, data.hour, data.minute, data.second, swisseph.SE_GREG_CAL);
      julianDayUT = julianDay['julianDayUT'];


      var houseData = swisseph.swe_houses_ex(julianDayUT, swisseph.SEFLG_SIDEREAL,
          birthData.latitude, birthData.longitude,'P');
      
      if (houseData.error)
        return {};

      // Set the ascendent
      result["Ascendant"] = houseData["ascendant"];

      for (var i = 0; i < Planets.length; i++) {
        var planet = Planets[i]
        swisseph.swe_calc_ut(julianDayUT, planet, flag, function(body) {
          // Set each planets returned data
          result[swisseph.swe_get_planet_name(planet).name] = body;
        });
      }
    });
    return result;
  }
};


