'use strict'

angular.module 'filters', []
    .filter 'default', ->
        (value, defaultText) ->
            if defaultText is null or typeof defaultText is 'undefined'
                defaultText = ''

            if value is null or typeof value is 'undefined'
                value = defaultText
            else
                value = value
