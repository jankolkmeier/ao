module.exports = (db) ->

    async = require 'async'

    this.authed = (req, res) ->
        if not req.session.user
            res.redirect '/login?redirect='+req.url
            return false
        return true

    # Exceptions
    this.NotFound = (msg, redirect) ->
        this.name = 'NotFound'
        this.msg = msg
        this.redirect = redirect
        Error.call this, msg
        Error.captureStackTrace this, arguments.callee
    this.NotFound.prototype.__proto__ = Error.prototype

    this.DBError = (msg, redirect, err) ->
        this.name = 'DBError'
        this.msg = msg
        this.redirect = redirect
        this.error = err
        Error.call this, msg
        Error.captureStackTrace this, arguments.callee
    this.DBError.prototype.__proto__ = Error.prototype

    this.findItem = (model, id, redir, next, cb) ->
        model.findById id, (err, item) ->
            return cb(false) if not next and (err or not item)
            if err
                return next new this.DBError("Can't get Item", redir, err)
            if not item
                return next new this.NotFound("Unknown Item", redir, err)
            cb(item)
        
    this.findUser = (id, next, cb) ->
        this.findItem db.User, id, '/users', next, cb

    this.findChore = (id, next, cb) ->
        this.findItem db.Chore, id, '/chores', next, cb

    this.getLog = (since, userid, choreid, next, cb) ->
        query = db.Log.find({})
        if userid
            query.where('userid', userid)
        if choreid
            query.where('choreid', userid)
        query.sort('date', -1)
        query.exec (err, logs) ->
            return next new this.DBError("Can't get Log", '/', err) if err
            loglist = []
            for log in logs
                if true # date younger than since
                   loglist.push({ log: log })  
                else
                    break
            async.forEach loglist, (log, cb) ->
                this.findUser log.log.userid, false, (user) ->
                    log.user = user
                    this.findChore log.log.choreid, false, (chore) ->
                        log.chore = chore
                        return cb(not user or not chore)
            , (err) ->
                return next new this.DBError("Can't get Details", '/', err) if err
                cb loglist

    return this
