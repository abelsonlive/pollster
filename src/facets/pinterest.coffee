request = require 'request'
{CouldNotFetch, Facet} = require '../models'
utils = require '../utils'

class module.exports extends Facet
    fetch: (url, callback) ->
        params =
            uri: 'http://api.pinterest.com/v1/urls/count.json'
            qs:
                url: url
            json: no

        request.get params, (err, response, body) ->
            # Pinterest only does JSONP, so we have to
            # strip out the padding to get to the JSON.
            result = utils.jsonp.parse body

            if err or response.statusCode isnt 200
                callback new CouldNotFetch()
            else
                callback null, result.count