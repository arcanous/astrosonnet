angular.module('astrosonnetApp')
.factory('geoService', ($http) ->
   return {getCities: ((state) ->
      return $http.get("/json/cities/#{state}.json"))
      }
)
.factory('tzService', ($http) ->
  return {getTzName: ((latitude, longitude) ->
    # All we care about is TZ/Olson name for given location. All other details taken care of moment-timezone js.
    # Until R-tree approach is implemented
    return 'America/Los_Angeles')
    }
)