'use strict'

studentMgmtApp = angular.module 'studentMgmtApp', [
	'ngRoute'
	'StudentManagementControllers'
	'filters',
	'directives'
]

studentMgmtApp.config [
	'$routeProvider'
	($routeProvider) ->
		$routeProvider
			.when '/',
				templateUrl: 'partials/index.html'
				controller: 'IndexController'
			.when '/about',
				templateUrl: 'partials/about.html'
			.when '/add',
				templateUrl: 'partials/save.html'
				data: '@@'
			.otherwise
				redirectTo: '/'
]