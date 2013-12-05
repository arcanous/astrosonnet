RegexIso8601 = /^(\d{4}|\+\d{6})(?:-(\d{2})(?:-(\d{2})(?:T(\d{2}):(\d{2}):(\d{2})\.(\d{1,})(Z|([\-+])(\d{2}):(\d{2}))?)?)?)?$/

angular.module('astrosonnetApp')
.factory('datetimeParse', ->
  return {
    getDate: ((input) -> 
      return input unless typeof input is "string"
      return {month: 0, day: 0, year: 0}
    ),
    getTime: ((input) -> 
      return input unless typeof input is "string"
      return {hours: 0, minutes: 0, seconds: 0}
    ),
  })
.factory('geoService', ($http) ->
   return {getCities: ((state) ->
      return $http.get("http://api.sba.gov/geodata/city_county_links_for_state_of/#{state}.json"))
      }
)