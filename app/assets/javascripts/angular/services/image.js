app.factory('Image', ['$resource', function($resource) {
  function Image() {
    this.service = $resource('/api/images/:imageId', {imageId: '@id'});
  };
  Image.prototype.all = function() {
    return this.service.query();
  };
  return new Image;
}]);
