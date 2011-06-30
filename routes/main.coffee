module.exports = (web, db, u) ->

    web.get '/', (req, res, next) ->
        u.getLog 0, false, false, next, (logs) ->
            u.getRunningConflicts false, (conflicts) ->
                res.render 'index', context :
                    user : req.session.user
                    logs : logs
                    conflicts : conflicts

    web.error (err, req, res, next) ->
        if err instanceof u.Err
            return res.render 'error', context : { error : err }
        next(err)
