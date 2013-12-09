angular.module('astrosonnetApp')
.factory('geoService', ($http) ->
   return {getCities: ((state) ->
      return $http.get("/json/cities/#{state}.json"))
      }
)
.factory('tzService', ($http) ->
  return {getTzName: ((latitude, longitude) ->
    coordinates =
      longitude: longitude
      latitude: latitude
    return $http.post("/api/timezone", coordinates))
    }
)