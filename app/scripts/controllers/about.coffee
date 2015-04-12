'use strict'

###*
 # @ngdoc function
 # @name weatherIoAppAngularMaterialApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the weatherIoAppAngularMaterialApp
###
angular.module 'weatherIoAppCoffeeApp'
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
