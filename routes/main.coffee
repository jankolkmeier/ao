module.exports = (web, db, h) ->

    web.get '/', (req, res, next) ->
        h.getLog 0, false, false, next, (logs) ->
            res.render 'index', context :
                user : req.session.user
                logs : logs

    web.error (err, req, res, next) ->
        if err instanceof h.DBError or err instanceof h.NotFound
            return res.render 'error', context : { error : err }
        next(err)


