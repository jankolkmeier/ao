module.exports = (web, db, u) ->
    web.get '/chores', (req, res, next) ->
        u.getAll 'chores', (docs) ->
            res.render 'chores', context : { chores : docs }

    web.get '/chores/new', (req, res) ->
        if not u.authed(req, res) then return
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
                    chore.id = db.genKey()
                chore.groupid = req.session.user.groupid
                db.chores.set chore.id, chore, () ->
                    res.redirect '/chore/'+chore.id
        if req.body.id
            u.findChore req.body.id, next, cb
        else
            cb({})

    web.get '/chores/edit/:id', (req, res, next) ->
        if not u.authed(req, res) then return
        u.findChore req.params.id, next, (chore) ->
            res.render 'editchore', context :
                chore : chore
                scenario : u.scenario

    web.get '/chore/:id', (req, res, next) ->
        u.findChore req.params.id, next, (chore) ->
            res.render 'chore', context :
                chore : chore
                scenario : u.scenario

    web.get '/chores/do/:id', (req, res, next) ->
        if not u.authed(req, res, next) then return
        u.getPayoff req.session.user, req.params.id, (err, hedons, collectons, chore) ->
            if err
                return next new u.PayoffError "Can't Calculate Payoff",
                    '/chore/'+req.params.id, err
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
            db.logs.set newLog.id, newLog, () ->
                res.redirect '/'

    web.get '/api/conflict/:id', (req, res, next) ->
        u.findConflict req.params.id, next, (conflict) ->
            res.send { conflict: conflict }

    web.get '/chores/conflict/:id', (req, res, next) ->
        return if not u.authed(req, res)
        u.findChore req.params.id, next, (chore) ->
            # TODO: ONLY GROUPID USERS!!!
            u.getAll 'users', (users) ->
                res.render 'startconflict', context :
                    chore : chore
                    scenario : u.scenario
                    users : users

    web.post '/chores/startconflict', (req, res, next) ->
        return if not u.authed(req, res)
        u.parseConflictBody req.body, (conflict) ->
            conflict.id = db.genKey()
            newLog =
                eventtype : 'conflict_start'
                conflictid : conflict.id
                date : Date.now()
                id : db.genKey()
            db.conflicts.set conflict.id, conflict, () ->
                db.logs.set newLog.id, newLog, () ->
                    res.redirect '/conflict/'+conflict.id

    web.get '/conflicts', (req, res, next) ->
        u.getAll 'conflicts', (conflicts) ->
            res.render 'conflicts', context :
                conflicts: conflicts

    web.get '/conflict/:id', (req, res, next) ->
        u.findConflict req.params.id, next, (conflict) ->
            res.render 'conflict', context :
                conflict: conflict
