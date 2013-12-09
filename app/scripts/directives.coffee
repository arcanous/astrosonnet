angular.module('astrosonnetApp')
.directive('stateSamples', ['geoService', (geoService) ->
  return {
      restrict: 'A',
      link: (scope, element, attrs) ->
        $(element).on 'change',  (e) ->
          return {} unless e.target.value.length
          geoService.getCities(e.target.value).then (result) ->
            scope.cities = [city for city in result.data][0]
  }])
.directive('citySamples', ['tzService', (tzService) ->
  return {
    restrict: 'A',
    link: (scope, element, attrs) ->
      $(element).on 'change',  (e) ->
        return {} unless e.target.value.length

        city = scope.data.city
        tzService.getTzName(city.primary_latitude, city.primary_longitude).then (result) ->
          scope.data.timezone = result.data.tzid
  }])