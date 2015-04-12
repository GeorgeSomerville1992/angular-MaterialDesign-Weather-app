'use strict'

###*
 # @ngdoc overview
 # @name weatherIoAppAngularMaterialApp
 # @description
 # # weatherIoAppAngularMaterialApp
 #
 # Main module of the application.
###
angular
  .module 'weatherIoAppCoffeeApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ngMaterial'
  ]
  .controller 'navController',['$mdSidenav','$scope', '$q',($mdSidenav,$scope,$q) ->

    $scope.toggleForm = ->
      console.log("going!")
      pending = $q.when(true);
      pending.then ->
        $mdSidenav('left').toggle()
        return
    ]
  .config ($routeProvider,$mdThemingProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'views/main.html'
        controller: 'MainCtrl'
      .when '/about',
        templateUrl: 'views/about.html'
        controller: 'AboutCtrl'
      .when '/weatherIoCoffee', 
        templateUrl: 'views/weatherIoCoffee.html'
        controller: "WeatherIoCoffeeCtrl" 
      # .when '/testTiles',
      #   templateUrl: 'views/testTiles.html'
      #   controller:"gridListDemoCtrl",
      .otherwise
        redirectTo: '/'
    # $mdThemingProvider.theme 'default'
    #   .primaryPalette '#FFFFFF'
    #   .accentPalette 'orange' 

