module.exports = (web, db, u) ->
    web.get '/chores', (req, res, next) ->
        u.getAll 'chores', (docs) ->
            res.render 'chores', context : { chores : docs }

    web.get '/chores/new', (req, res) ->
        if not u.authed(req, res) then return
        u.loadScenario () ->
            res.render 'editchore', context:
                scenario : u.scenario
  
    web.post '/chores/remove/:id', (req, res, next) ->
        return if not u.authed(req, res)
        db.chores.rm req.params.id, () ->
            res.redirect '/chores'

    web.post '/chores/save', (req, res, next) ->
        return if not u.authed(req, res)
        cb = (chore) ->
            u.parseChoreBody chore, req.body, (chore) ->
                if not chore.id
                    chore.id = db.keyFromProperty(chore.name)
                chore.groupid = req.session.user.groupid
                db.chores.set chore.id, chore, () ->
                    res.redirect '/chores'
        if req.body.id
            u.findChore req.body.id, next, cb
        else
            cb({})

    web.get '/chores/edit/:id', (req, res, next) ->
        if not u.authed(req, res) then return
        u.loadScenario () ->
            u.findChore req.params.id, next, (chore) ->
                res.render 'editchore', context :
                    chore : chore
                    scenario : u.scenario

    web.get '/chore/:id', (req, res, next) ->
        if not u.authed(req, res, next) then return
        u.getPayoff req.session.user, req.params.id, (err, hedons, collectons, chore) ->
            res.render 'chore', context :
                chore : chore
                scenario : u.scenario
                hedons : hedons
                collectons : collectons


    web.post '/chores/do/:id', (req, res, next) ->
        if not u.authed(req, res, next) then return
        u.getPayoff req.session.user, req.params.id, (err, hedons, collectons, chore) ->
            if err
                return next new u.Err("Can't Calculate Payoff",
                    '/chore/'+req.params.id)
            u.checkRunningConflicts req.params.id, (conflicts) ->
                relevantConflicts = []
                if chore.impact == 'individual'
                    for conflict in conflicts
                        if conflict.userid and conflict.userid == req.session.user.id
                            relevantConflicts.push(conflict)
                    conflicts = relevantConflicts
                newLog =
                    eventtype : 'progress'
                    userid : req.session.user.id
                    choreid : req.params.id
                    groupid : req.session.user.groupid
                    impact : chore.impact
                    hedons : hedons
                    collectons : collectons
                    date : Date.now()
                    id : db.genKey()
                    scene : chore.progress
                    parameters : chore['progress_parameters']
                if conflicts.length == 1
                    newLog.eventtype = 'conflict_solved'
                    newLog.conflictid = conflicts[0].id
                    conflicts[0].ended = true
                    db.conflicts.set conflicts[0].id, conflicts[0]
                if conflicts.length > 1
                    console.log "WTF MULTIPLE CONFLICTS???"
                db.logs.set newLog.id, newLog, () ->
                    if conflicts.length == 1
                        res.redirect '/chores/review/'+newLog.id+'/'+conflicts[0].id
                    else
                        res.redirect '/chores/review/'+newLog.id
                    
    web.get '/chores/review/:logid/:conflictid', (req, res, next) ->
        u.findLog req.params.logid, next, (log) ->
            u.findChore log.choreid, next, (chore) ->
                u.findConflict log.conflictid, next, (conflict) ->
                    console.log conflict
                    res.render 'review', context : {
                        scenario : u.scenario
                        log   : log
                        chore : chore
                        conflict : conflict
                    }

    web.get '/chores/review/:logid', (req, res, next) ->
        u.findLog req.params.logid, next, (log) ->
            u.findChore log.choreid, next, (chore) ->
                res.render 'review', context : {
                    scenario : u.scenario
                    log   : log,
                    chore : chore,
                }

