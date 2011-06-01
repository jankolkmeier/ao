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
        u.getPayoff req.session.user, req.params.id, (err, hedons, collectons, quest) ->
            if err
                return next new u.PayoffError "Can't Calculate Payoff",
                    '/chore/'+req.params.id, err
            newLog = new db.Log {
                userid : req.session.user._id
                choreid : req.params.id
                quest : quest
                hedons : hedons
                collectons : collectons
                scenarioVersion : u.getScenarioVersion()
            }
            newLog.save (err) ->
                return next new u.DBError("Can't Log this", '/chore/'+req.params.id, err) if err
            res.redirect '/'
