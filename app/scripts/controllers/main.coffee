'use strict'

###*
 # @ngdoc function
 # @name weatherIoAppAngularMaterialApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the weatherIoAppAngularMaterialApp
###
angular.module 'weatherIoAppCoffeeApp'
  .controller 'MainCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
