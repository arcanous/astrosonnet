angular.module('astrosonnetApp')
.directive('stateSamples', ['geoService', (geoService) ->
  return {
      restrict: 'A',
      link: (scope, element, attrs) ->
        $(element).on 'change',  (e) ->
          return {} unless e.target.value.length
          scope.data.timezone = null
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
.directive('submitButton', ->
  # TODO: consider moving this logic to the end of the submit function
  return {
      restrict: 'A',
      link: (scope, element, attrs) ->
        $(element).on 'click', (e) ->
          if scope.astroAction is scope.astroSubmit
            $(e.target).html('Start Over')
          else
            $(e.target).html('Submit')
  })