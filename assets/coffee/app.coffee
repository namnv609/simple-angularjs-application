'use strict'

studentMgmtApp = angular.module 'studentMgmtApp', [
    'ngRoute'
    'ngAnimate'
    'StudentManagementControllers'
    'filters'
    'directives'
    'ngMaterial'
]

studentMgmtApp.config [
    '$routeProvider'
    '$mdThemingProvider'
    ($routeProvider, $mdThemingProvider) ->
        $routeProvider
            .when '/',
                templateUrl: 'partials/index.html'
                controller: 'IndexController'
            .when '/about',
                templateUrl: 'partials/about.html'
            .when '/add',
                templateUrl: 'partials/save.html'
            .when '/edit/:studentId',
                controller: 'IndexController'
                templateUrl: 'partials/save.html'
            .when '/students/:studentId',
                controller: 'StudentController'
                templateUrl: 'partials/student-detail.html'
            .otherwise
                redirectTo: '/'
        $mdThemingProvider
            .theme 'default'
            .primaryPalette 'blue'
            .accentPalette 'green'
]

studentMgmtApp.run ($rootScope) ->
    $rootScope.$on '$routeChangeStart', ->
        time = new Date().getTime()
        console.log "Start: #{time}"
    $rootScope.$on '$viewContentLoaded', ->
        time = new Date().getTime()
        console.log "Done: #{time}"
