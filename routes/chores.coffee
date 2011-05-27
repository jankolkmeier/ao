module.exports = (web, db, u) ->
    web.get '/chores', (req, res, next) ->
        db.Chore.find {}, (err, docs) ->
            return next new u.DBError("Can't get Chores", '/chores', err) if err
            res.render 'chores', context : { chores : docs }

    web.get '/chores/new', (req, res) ->
        if not u.authed(req, res) then return
        res.render 'editchore', context:
            quests : u.getQuests()
  

    web.get '/chores/remove/:id', (req, res, next) ->
        res.redirect '/chore/'+req.params.id

    web.post '/chores/remove/:id', (req, res, next) ->
        return if not u.authed(req, res)
        db.Chore.remove { _id : req.params.id }, (err) ->
            return next new u.DBError("Remove Failed", '/chores', err) if err
            res.redirect '/chores'

    web.post '/chores/save', (req, res, next) ->
        return if not u.authed(req, res)
        cb = (chore) ->
            chore.name = req.body.name
            chore.impact = req.body.impact
            chore.occurence = req.body.occurence
            chore.quest = req.body.quest
            chore.save (err) ->
                if err and err.name == 'ValidationError'
                    return res.render 'editchore', context :
                        error : err,
                        chore : newChore
                        quests : u.getQuests()
                return next new u.DBError("Can't save Chore", '/chores/new', err) if err
                res.redirect '/chore/'+chore.id
        if req.body.id
            u.findChore req.body.id, next, cb
        else
            newChore = new db.Chore()
            cb newChore

    web.get '/chores/edit/:id', (req, res, next) ->
        if not u.authed(req, res) then return
        u.findChore req.params.id, next, (chore) ->
            res.render 'editchore', context :
                chore : chore
                quests : u.getQuests()

    web.get '/chore/:id', (req, res, next) ->
        u.findChore req.params.id, next, (chore) ->
            res.render 'chore', context : { chore : chore }

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
