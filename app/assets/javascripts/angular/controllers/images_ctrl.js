app.controller('ImagesCtrl', ['$scope', 'Image', function($scope, Image) {
  $scope.images = Image.all();
}]);
