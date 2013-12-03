'use strict'

angular.module('astrosonnetApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'angular-selectize'
])
  .config ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'partials/main'
        controller: 'MainCtrl'
      .otherwise
        redirectTo: '/'
    $locationProvider.html5Mode(true)