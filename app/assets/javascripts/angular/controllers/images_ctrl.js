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
		$scope.errors = null;
		$scope.newImage = Image.save($scope.newform);
		$scope.newImage.$promise.then(function(data){
			$scope.orig_url = location.origin + data.image_url.split('?')[0];
			$scope.thumb_url = location.origin + data.image_thumb_url.split('?')[0];
			$scope.images.push($scope.newImage);
		}, function(error){
			$scope.errors = "Failed to make love. Try to love something else.";
			$scope.newImage = null;
		});
		$scope.newform = {};
	};
	
	// Bootstrap tooltips
	$('body').tooltip({
	    selector: '[data-toggle="tooltip"]'
	});
}]);
