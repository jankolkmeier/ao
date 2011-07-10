module.exports = (web, db, u) ->
    web.get '/api/logs/:since', (req, res, next) ->
        logs = []
        cbdone = () ->
            res.send { logs:logs }
        db.logs.forEach cbdone, (key, val) ->
            if val.date>parseInt(req.params.since)
                logs.push val

    web.get '/api/group/:id', (req, res, next) ->
        u.findGroup req.params.id, next, (group) ->
            res.send { group: group }

    web.get '/api/user/:id', (req, res, next) ->
        u.findUser req.params.id, next, (user) ->
            res.send { user: user }

    web.get '/api/conflict/:id', (req, res, next) ->
        u.findConflict req.params.id, next, (conflict) ->
            res.send { conflict: conflict }

