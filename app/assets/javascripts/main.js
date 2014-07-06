var app = angular.module("ilove", ['ngResource','ngRoute','templates']);

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);
  $routeProvider.
    when('/', {templateUrl: 'index.html'}).
    when('/new', {templateUrl: 'new.html'}).
    otherwise({redirectTo: '/'});
}]);
