'use strict';

var mongoose = require('mongoose'),
    Thing = mongoose.model('Thing'),
    async = require('async');

exports.awesomeThings = function(req, res) {
  return Thing.find(function (err, things) {
    if (!err) {
      return res.json(things);
    } else {
      return res.send(err);
    }
  });
};

exports.chart = function(req, res) {
  return res.send(chartHelper(req.body));
  
  function chartHelper(chartAttributes) {
    var swisseph = require('swisseph');
    var date, flag, result;
    result = {};
    date = {
      year: chartAttributes.year,
      month: chartAttributes.month,
      day: chartAttributes.day,
      hour: chartAttributes.hour,
      minute: chartAttributes.minute,
      second: chartAttributes.second,
      timezone: chartAttributes.timezone
    };
    swisseph.swe_set_topo(chartAttributes.longitude, chartAttributes.latitude, chartAttributes.altitude);
    flag = swisseph.SEFLG_SPEED | swisseph.SEFLG_SIDEREAL | swisseph.SEFLG_SWIEPH;
    swisseph.swe_set_sid_mode(swisseph.SE_SIDM_LAHIRI, 0, 0);
    swisseph.swe_set_ephe_path('/Users/kbdaitch/code/swisseph/');
    swisseph.swe_utc_time_zone(date.year, date.month, date.day, date.hour, date.minute, date.second, date.timezone, function(data) {
      var julianday, julianday_ut;
      julianday = swisseph.swe_utc_to_jd(data.year, data.month, data.day, data.hour, data.minute, data.second, swisseph.SE_GREG_CAL);
      julianday_ut = julianday['julianDayUT'];
      swisseph.swe_calc_ut(julianday_ut, swisseph.SE_SUN, flag, function(body) {
        result["Sun"] = body;
      });
      swisseph.swe_calc_ut(julianday_ut, swisseph.SE_MOON, flag, function(body) {
        result["Moon"] = body;
      });
      swisseph.swe_calc_ut(julianday_ut, swisseph.SE_JUPITER, flag, function(body) {
        result["Jupiter"] = body;
      });
      swisseph.swe_calc_ut(julianday_ut, swisseph.SE_MARS, flag, function(body) {
        result["Mars"] = body;
      });
      return swisseph.swe_calc_ut(julianday_ut, swisseph.SE_SATURN, flag, function(body) {
        result["Saturn"] = body;
      });
    });
    return result;
  };

};
