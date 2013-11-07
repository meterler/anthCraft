'use strict';

describe('Controller: MainCtrl', function () {

  var MainCtrl,
    scope,
    $httpBackend;
  var createController;

  // load the controller's module
  beforeEach(angular.module('anthCraftApp'));
  console.log('----------------------------------1');


  // Initialize the controller and a mock scope
  beforeEach(inject(function ($injector) {
    $httpBackend = $injector.get('$httpBackend');

    $httpBackend.expectGET('/api/awesomeThings')
      .respond(['HTML5 Boilerplate', 'AngularJS', 'Karma', 'Express2']);

    var $rootScope = $injector.get('$rootScope');
    var $controller = $injector.get('$controller');

    scope = $rootScope.$new();
    MainCtrl = $controller('MainCtrl', {
      $scope: scope
    });

    // createController = function() {
    //   console.log('----------------------------------2');
    //   return $controller('MainCtrl', { $scope: scope });
    // };
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    createController();
    console.log('----------------------------------3', MainCtrl);
    expect(scope.awesomeThings).toBeUndefined();
    $httpBackend.flush();
    expect(scope.awesomeThings.length).toBe(4);
  });
});
