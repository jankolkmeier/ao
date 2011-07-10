module.exports = (web, db, u) ->
    crypto  = require('crypto')

    web.get '/groups', (req, res, next) ->
        u.getAll 'groups', (docs) ->
            res.render 'groups', context :
                groups : docs

    web.get '/groups/new', (req, res) ->
        res.render 'editgroup'

    web.get '/group/:id', (req, res, next) ->
        u.findGroup req.params.id, next, (group) ->
            res.render 'group', context :
                group : group

    web.post '/groups/remove/:id', (req, res, next) ->
        return if not u.authed(req, res)
        db.Group.remove { _id : req.params.id }, (err) ->
            return next new u.DBError("Remove Failed", '/groups', err) if err

    web.post '/groups/save', (req, res, next) ->
        cb = (group) ->
            group.name = req.body.name
            if not group.id
                group.id = u.genKey()
            db.groups.set group.id, group, () ->
                res.redirect '/group/'+group.id
        if req.body.id
            u.findGroup req.body.id, next, cb
        else
            cb {}

    web.get '/groups/edit/:id', (req, res, next) ->
        if not u.authed(req, res) then return
        u.findGroup req.params.id, next, (group) ->
            res.render 'editgroup', context :
                group : group

    web.get '/group/:id', (req, res, next) ->
        u.findGroup req.params.id, next, (group) ->
            res.render 'group', context : { group : group }
