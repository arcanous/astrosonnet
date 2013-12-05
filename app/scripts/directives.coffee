angular.module('astrosonnetApp')
.directive('stateSamples', ['geoService', (geoService) ->
  return {
      restrict: 'A',
      link: (scope, element, attrs) ->
        _geoService = geoService
        $(element).on 'change',  (e) ->
          return {} unless e.target.value.length
          _geoService.getCities(e.target.value).then (result) ->
            scope.cities = [city for city in result.data][0]
  }])