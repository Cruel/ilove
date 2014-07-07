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
  	return this.service.remove({imageId: id});
  };
  Image.prototype.save = function(data) {
  	/*
  	console.log(data);
  	var newImage = new this.service({test:23});
  	newImage.$save();
  	return newImage;*/
  	return this.service.save(data);
  };
  return new Image;
}]);
