'use strict'
Constellations = [
  "Aries", "Taurus", "Gemini", "Cancer",
  "Leo", "Virgo", "Libra", "Scorpio",
  "Sagittarius", "Capricorn", "Aquarius", "Pisces"]

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

    # Master copy of scope - resets to this, starts at this
    $scope.master= 
      output: {}
  
    # Initialize scope to master
    $scope.data = angular.copy($scope.master)

    # Static data
    $scope.states = States

    $scope.getClass = (b) ->
      return b.toString()

    $scope.astroReset = ->
      $scope.astroForm.$setPristine()
      $scope.astroAction = $scope.astroSubmit
      $scope.data = angular.copy($scope.master)

    $scope.astroSubmit = ->
      $scope.astroAction = $scope.astroReset
            
      console.log(@.data.timezone)
      birthDate = moment.tz(new Date(@.data.birthDate), @.data.timezone)

      postData = 
        year: birthDate.year()
        month: birthDate.month() + 1
        day: birthDate.date()
        hour:  birthDate.hours()
        minute: birthDate.minutes()
        second: birthDate.seconds()
        timezone: (birthDate.zone() / 60) * -1
        longitude: parseFloat(@.data.city.primary_longitude)
        latitude: parseFloat(@.data.city.primary_latitude) 
        altitude: 0

      #scope = @
      $http.post('/api/chart', postData).success (chartData) =>
        ascHouse = 1
        console.dir(chartData)

        ascHouse = Math.floor(chartData["Ascendant"] / 30)
        constellations = Constellations.slice(ascHouse).concat Constellations.slice(0,ascHouse)

        planets = []
        for planet, data of chartData
          constNum = Math.floor(data.longitude / 30)
          planets[constNum] or= []
          planets[constNum].push planet

        # TODO: a better way to not have holes
        planets[i] or= [] for i in [0..11]

        # Reorient
        planets = planets.slice(ascHouse).concat planets.slice(0,ascHouse)
        planets[0].push "Ascendant"

        planets = planets.map (planetsInHouse) ->
          planetsInHouse.join(', ')

        @.data.output.chart = []
        for i in [0..11]
          @.data.output.chart[i] =
            house: i+1
            constellation: constellations[i]
            planets: planets[i]
        
        @.data.output.url = "partials/chart.jade"

    # Initial action is to submit
    $scope.astroAction = $scope.astroSubmit

    