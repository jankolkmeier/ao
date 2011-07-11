# Scenario Loader
module.exports = (u, db, s) ->
    u.scenario = {}

    request = require('request')

    u.loadScenario = (cb) ->
        u.findSettings 'settings', false, (settings) ->
            if not settings or not settings.scenarioUri
                console.log "Couldn't load Scenario because settings aren't made"
            else if settings and settings.scenarioUri
                request uri:settings.scenarioUri, (err, res, body) ->
                    success = not err and res.statusCode == 200
                    if success
                        u.scenario = JSON.parse(body)['scenario']
                        console.log "loaded Scenario"
                    else
                        console.log "Couldn't load Scenario: "
                        console.log err
                    cb(not success) if cb

    u.parseChoreBody = (chore, body, cb) ->
        for attr in ['name', 'desc', 'impact', 'occurence', 'progress', 'conflict']
            if attr == 'progress' or attr == 'conflict'
                chore[attr] = body[chore.impact+'_'+attr]
            else
                chore[attr] = body[attr]
        for type in ['progress', 'conflict']
            chore[type+'_parameters'] = []
            for name,param of u.scenario.scenes[chore.impact][type][chore[type]].parameters
                paramid = type+"_"+chore[type]+"_"+name
                value = body[paramid]
                chore[type+'_parameters'].push
                    name : name
                    value : value
        cb chore
        
    u.parseConflictBody = (body, cb) ->
        chore = db.chores.get(body.id)
        conflict = {}
        conflict.choreid = chore.id
        conflict.impact = chore.impact
        if conflict.impact == "individual"
            conflict.userid = body.userid
        conflict.scene = body.conflict
        conflict.parameters = []
        conflict.start = Date.now()
        conflict.end = Date.now()+1000*parseInt(body.time)*parseInt(body.timeUnit)
        conflict.groupid = chore.groupid
        conflict.desc = u.scenario.scenes[chore.impact].conflict[conflict.scene].desc
        for name,param of u.scenario.scenes[chore.impact].conflict[conflict.scene].parameters
            paramid = "conflict_"+conflict.scene+"_"+name
            value = body[paramid]
            conflict.parameters.push
                name : name
                value : value
        cb conflict
