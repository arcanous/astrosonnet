angular.module('astrosonnetApp')
.factory('geoService', ($http) ->
   return {getCities: ((state) ->
      return $http.get("http://api.sba.gov/geodata/city_county_links_for_state_of/#{state}.json"))
      }
)