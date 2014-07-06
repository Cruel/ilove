app.factory('Image', ['$resource', function($resource) {
  function Image() {
    this.service = $resource('/api/images/:imageId', {imageId: '@id'});
  };
  Image.prototype.all = function() {
    return this.service.query();
  };
  Image.prototype.get = function(id) {
    return this.service.get({imageId: id});
  };
  Image.prototype.delete = function(id) {
  	this.service.remove({imageId: id});
  };
  return new Image;
}]);
