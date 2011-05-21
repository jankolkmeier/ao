module.exports = (web, db, h) ->

    web.get '/', (req, res) ->
        if not h.authed(req, res) then return
        res.render 'index', context : { user: req.session.user }

    web.error (err, req, res, next) ->
        if err instanceof h.DBError or err instanceof h.NotFound
            return res.render 'error', context : { error : err }
        next(err)

