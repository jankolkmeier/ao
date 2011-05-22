module.exports = (web, db, u) ->

    web.get '/', (req, res, next) ->
        u.getLog 0, false, false, next, (logs) ->
            res.render 'index', context :
                user : req.session.user
                logs : logs

    web.error (err, req, res, next) ->
        if err instanceof u.DBError or err instanceof u.NotFound
            return res.render 'error', context : { error : err }
        next(err)


