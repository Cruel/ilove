var app = angular.module("ilove", ['ngResource','ngRoute','templates','ngClipboard']);

app.config(['$routeProvider','$locationProvider','ngClipProvider', function($routeProvider, $locationProvider, ngClipProvider) {
  $locationProvider.html5Mode(true);
  ngClipProvider.setPath("/ZeroClipboard.swf");
  $routeProvider.
    when('/', {templateUrl: 'index.html'}).
    when('/new', {templateUrl: 'new.html'}).
    when('/image/:id', {templateUrl: 'show.html', controller:'ImagesCtrl'}).
    otherwise({redirectTo: '/'});
}]);

// Bootstrap tooltips
$('body').css('background','#eee').tooltip({
    selector: 'button'
});

