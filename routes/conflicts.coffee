module.exports = (web, db, u) ->
    web.get '/api/conflict/:id', (req, res, next) ->
        u.findConflict req.params.id, next, (conflict) ->
            res.send { conflict: conflict }

    web.get '/chores/startconflict/:id', (req, res, next) ->
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
            conflict.ended = false
            newLog =
                eventtype : 'conflict_start'
                conflictid : conflict.id
                date : Date.now()
                id : db.genKey()
            u.conflictOverlap conflict, (overlap) ->
                if overlap and conflict.impact == "group"
                    next new u.Err("This conflict is already open",
                        '/chore/'+conflict.choreid)
                else
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
