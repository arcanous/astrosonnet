'use strict'

angular.module('astrosonnetApp')
  .factory 'geoService', ($http) ->
     return {getCities: ((state) ->
        return $http.get("http://api.sba.gov/geodata/city_county_links_for_state_of/#{state}.json"))
      }
  .controller 'MainCtrl', ($scope, $http, geoService) ->
    data = 
      year: 1987
      month: 9
      day: 17
      hour:  11
      minute: 20
      second: 0
      timezone: 5.5
      longitude: 78.1780
      latitude: 26.2215
      altitude: 0

    $http.post('/api/chart', data).success (chartData) ->
      console.log(chartData)
    #$http.get('/api/awesomeThings').success (awesomeThings) ->
    #  $scope.awesomeThings = awesomeThings

    $(document).on 'change', '#select-state', (e) ->
      return {} unless e.target.value.length

      geoService.getCities(e.target.value).then (result) ->
        $scope.selectedValue = null
        $scope.getAvailableCities = [city.name for city in result.data][0]
