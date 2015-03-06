'use strict'
angular.module 'directives', []
	.directive 'ngHiddenField', ($parse) ->
		(scope, element, attrs) ->
			if attrs.ngModel
				if element[0].type is 'radio'
					$parse attrs.ngModel
						.assign scope, element.val()
				else
					scope.$watch attrs.ngModel, (newValue) ->
						$parse attrs.ngModel
							.assign scope, newValue