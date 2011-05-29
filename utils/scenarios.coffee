# Scenario Loader
module.exports = (u, db, settings) ->
    u.scenario = {}

    request = require('request')

    u.loadScenario = (cb) ->
        request uri:settings.scenarioUri, (err, res, body) ->
            success = not err and res.statusCode == 200
            if success
                u.scenario = JSON.parse(body)
            else
                console.log err
            cb(not success) if cb
