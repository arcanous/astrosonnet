'use strict'

angular.module('astrosonnetApp')
  .controller 'MainCtrl', ($scope, $http) ->
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

    #$scope.$watch 'getAvailableCities', (newValue, oldValue) ->

    #$http.get('/api/awesomeThings').success (awesomeThings) ->
    #  $scope.awesomeThings = awesomeThings

    