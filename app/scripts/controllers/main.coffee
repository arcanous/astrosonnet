'use strict'

States =
  "AL": "Alabama"
  "AK": "Alaska"
  "AZ": "Arizona"
  "AR": "Arkansas"
  "CA": "California"
  "CO": "Colorado"
  "CT": "Connecticut"
  "DE": "Delaware"
  "DC": "District of Columbia"
  "FL": "Florida"
  "GA": "Georgia"
  "HI": "Hawaii"
  "ID": "Idaho"
  "IL": "Illinois"
  "IN": "Indiana"
  "IA": "Iowa"
  "KS": "Kansas"
  "KY": "Kentucky"
  "LA": "Louisiana"
  "ME": "Maine"
  "MD": "Maryland"
  "MA": "Massachusetts"
  "MI": "Michigan"
  "MN": "Minnesota"
  "MS": "Mississippi"
  "MO": "Missouri"
  "MT": "Montana"
  "NE": "Nebraska"
  "NV": "Nevada"
  "NH": "New Hampshire"
  "NJ": "New Jersey"
  "NM": "New Mexico"
  "NY": "New York"
  "NC": "North Carolina"
  "ND": "North Dakota"
  "OH": "Ohio"
  "OK": "Oklahoma"
  "OR": "Oregon"
  "PA": "Pennsylvania"
  "RI": "Rhode Island"
  "SC": "South Carolina"
  "SD": "South Dakota"
  "TN": "Tennessee"
  "TX": "Texas"
  "UT": "Utah"
  "VT": "Vermont"
  "VA": "Virginia"
  "WA": "Washington"
  "WV": "West Virginia"
  "WI": "Wisconsin"
  "WY": "Wyoming"

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

    $scope.states = States

    $scope.data = {}

    #$scope.$watch 'getAvailableCities', (newValue, oldValue) ->

    #$http.get('/api/awesomeThings').success (awesomeThings) ->
    #  $scope.awesomeThings = awesomeThings

    