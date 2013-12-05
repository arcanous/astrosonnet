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
.directive('astroForm', ['datetimeParse', (datetimeParse) ->
  return {
      restrict: 'A',
      link: (scope, element, attrs) ->
        $(element).on 'submit', (e) ->
          el = $(@)
          birthDate = el.find('input[name="birthDate"]').val()
          birthDate = datetimeParse.getDate(birthDate)
          console.dir(birthDate)

          birthTime = el.find('input[name="birthTime"]').val()
          birthTime = datetimeParse.getTime(birthTime)
          console.dir(birthTime)

  }])