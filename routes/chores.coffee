module.exports = (web, db, h) ->
    web.get '/chores', (req, res, next) ->
        db.Chore.find {}, (err, docs) ->
            return next new h.DBError("Can't save Chore", '/chores/new', err) if err
            res.render 'chores', context : { chores : docs }

    web.get '/chores/new', (req, res) ->
        if not h.authed(req, res) then return
        res.render 'editchore'

    web.get '/chores/remove/:id', (req, res, next) ->
        res.redirect '/chore/'+req.params.id

    web.post '/chores/remove/:id', (req, res, next) ->
        return if not h.authed(req, res)
        db.Chore.remove { _id : req.params.id }, (err) ->
            return next new h.DBError("Remove Failed", '/chores', err) if err
            res.redirect '/chores'
            

    web.post '/chores/save', (req, res, next) ->
        return if not h.authed(req, res)
        cb = (chore) ->
            console.log chore
            chore.name = req.body.name
            chore.save (err) ->
                if err and err.name == 'ValidationError'
                    return res.render 'editchore', context : {
                        error : err,
                        chore : newChore
                    }
                return next new h.DBError("Can't save Chore", '/chores/new', err) if err
                res.redirect '/chore/'+chore.id
        if req.body.id
            h.findChore req.body.id, next, cb 
        else
            newChore = new db.Chore()
            cb newChore

    web.get '/chores/edit/:id', (req, res, next) ->
        if not h.authed(req, res) then return
        h.findChore req.params.id, next, (chore) ->
            res.render 'editchore', context : { chore : chore }

    web.get '/chore/:id', (req, res, next) ->
        h.findChore req.params.id, next, (chore) ->
            res.render 'chore', context : { chore : chore }

