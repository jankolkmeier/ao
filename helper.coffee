module.exports = (db) ->

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

    this.findUser = (id, next, cb) ->
        db.User.findById id, (err, user) ->
            if err
                return next new this.DBError("Can't get User", '/users', err)
            if not user 
                return next new this.NotFound("Unknown User", '/users', err)
            cb(user)

    this.findChore = (id, next, cb) ->
        db.Chore.findById id, (err, chore) ->
            if err
                return next new this.DBError("Can't get Chore", '/chores', err)
            if not chore
                return next new this.NotFound("Unknown Chore", '/chores', err)
            cb(chore)

    return this
