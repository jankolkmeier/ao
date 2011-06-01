# Scenario Loader
module.exports = (u, db, settings) ->
    u.scenario = {}

    request = require('request')

    u.loadScenario = (cb) ->
        request uri:settings.scenarioUri, (err, res, body) ->
            success = not err and res.statusCode == 200
            if success
                u.scenario = JSON.parse(body)['scenario']
            else
                console.log err
            cb(not success) if cb

    u.parseChoreBody = (chore, body, cb) ->
        console.log chore
        for attr in ['name', 'desc', 'impact', 'occurence', 'progress', 'conflict']
            if attr == 'progress' or attr == 'conflict'
                chore[attr] = body[chore.impact+'_'+attr]
            else
                chore[attr] = body[attr]
            console.log attr+" <- "+chore[attr]
        for type in ['progress', 'conflict']
            console.log type
            for i in [0..chore[type+'_params'].length]
                chore[type+'_params'][0]?.remove()
            for name,param of u.scenario.scenes[chore.impact][type][chore[type]].params
                paramid = type+"_"+chore[type]+"_"+name
                value = body[paramid]
                chore[type+'_params'].push {
                    name : name
                    value : value
                }
        cb(chore)
