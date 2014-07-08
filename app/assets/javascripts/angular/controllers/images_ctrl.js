app.controller('ImagesCtrl', ['$scope', 'Image', '$routeParams', function($scope, Image, $routeParams) {
	// Check if route passed an id for show.html
	if ($routeParams.id) {
		$scope.image = Image.get($routeParams.id);
		return;
	}
	$scope.images = Image.all();
	$scope.newform = {};
	$scope.location = location;

	$scope.processForm = function() {
		$scope.newImage = Image.save($scope.newform);
		$scope.newImage.$promise.then(function(data){
			$scope.orig_url = location.origin + data.image_url.split('?')[0];
			$scope.thumb_url = location.origin + data.image_thumb_url.split('?')[0];
		});
		$scope.newform = {};
		$scope.images.push($scope.newImage);
	};
	
	// Bootstrap tooltips
	$('body').tooltip({
	    selector: '[data-toggle="tooltip"]'
	});
}]);
