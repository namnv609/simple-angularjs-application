'use strict'

# Register controller
studentMgmtApp = angular.module 'StudentManagementControllers', []

# Index controller with
# $scope: Obj referes to app model
# $http: Request obj
studentMgmtApp.controller 'IndexController', [
	'$scope'
	'$http'
	'$parse',
	($scope, $http, $parse) ->
		$scope.students = {}
		$scope.filter =
			by: 'id'
			dir: true

		$http
			.get 'api/students.php'
			.success httpGetSuccess = (response) ->
				$scope.students = response if Object.keys(response).length > 0
			.error httpGetError = (error) ->
				console.log error


		## Filter function for on change directive
		$scope.filterDirection = ->
			isDesc = yes

			isDesc = no if $scope.filter.dir is 'false'

			$scope.filter.dir = isDesc

		$scope.saveStudent = ->
			$http
				.post 'api/students.php?action=save', $scope.student
				.success httpPostSuccess = (response) ->
					console.log response
				.error httpPostError = (error) ->
					console.log error
]

