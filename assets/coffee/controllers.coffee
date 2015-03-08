'use strict'

# Register controller
studentMgmtApp = angular.module 'StudentManagementControllers', []

# Index controller with
# $scope: Obj referes to app model
# $http: Request obj
studentMgmtApp.controller 'IndexController', [
	'$scope'
	'$http'
	'$parse'
	'$mdToast'
	'$routeParams'
	($scope, $http, $parse, $mdToast, $routeParams) ->
		$scope.students = {}

		if $routeParams.studentId
			$http
				.get "api/students.php?action=student&id=#{$routeParams.studentId}"
				.success httpGetSuccess = (res) ->
					$scope.student = res
				.error httpGetError = (error) ->
					console.log error
		else

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
			console.log 'aaaa'
			$scope.filter.dir = isDesc

		$scope.saveStudent = ->
			$http
				.post 'api/students.php?action=save', $scope.student
				.success httpPostSuccess = (response) ->
					if response.status isnt false
						showToastMessage response.message
						if not response.action
							$scope.student = {}
					else
						showToastMessage "All fields is required"
				.error httpPostError = (error) ->
					console.log error

		showToastMessage = (message) ->
			$mdToast.show(
				$mdToast.simple()
					.content message
					.position 'bottom left right'
					.hideDelay 3000
			)
			
]

studentMgmtApp.controller 'StudentController', [
	'$scope'
	($scope) ->
		console.log 'OK'
]