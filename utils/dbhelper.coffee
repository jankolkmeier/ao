# Database Helpers
module.exports = (u, db) ->
    async = require 'async'

    u.findItem = (model, id, redir, next, cb) ->
        model.findById id, (err, item) ->
            return cb(false) if not next and (err or not item)
            if err
                return next new u.DBError("Can't get Item", redir, err)
            if not item
                return next new u.NotFound("Unknown Item", redir, err)
            cb(item)
        
    u.findUser = (id, next, cb) ->
        u.findItem db.User, id, '/users', next, cb

    u.findChore = (id, next, cb) ->
        u.findItem db.Chore, id, '/chores', next, cb

    u.getLog = (since, userid, choreid, next, cb) ->
        query = db.Log.find({})
        if userid
            query.where('userid', userid)
        if choreid
            query.where('choreid', userid)
        query.sort('date', -1)
        query.exec (err, logs) ->
            return next new u.DBError("Can't get Log", '/', err) if err
            loglist = []
            for log in logs
                if true # date younger than since
                   loglist.push({ log: log })  
                else
                    break
            async.forEach loglist, (log, cb) ->
                u.findUser log.log.userid, false, (user) ->
                    log.user = user
                    u.findChore log.log.choreid, false, (chore) ->
                        log.chore = chore
                        return cb(not user or not chore)
            , (err) ->
                return next new u.DBError("Can't get Details", '/', err) if err
                cb loglist
