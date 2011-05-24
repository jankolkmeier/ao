# Exceptions
module.exports = (u, db) ->
    u.NotFound = (msg, redirect) ->
        this.name = 'NotFound'
        this.msg = msg
        this.redirect = redirect
        Error.call this, msg
        Error.captureStackTrace this, arguments.callee
    u.NotFound.prototype.__proto__ = Error.prototype

    u.DBError = (msg, redirect, err) ->
        this.name = 'DBError'
        this.msg = msg
        this.redirect = redirect
        this.error = err
        Error.call this, msg
        Error.captureStackTrace this, arguments.callee
    u.DBError.prototype.__proto__ = Error.prototype
    
    u.PayoffError = (msg, redirect, err) ->
        this.name = 'PayoffError'
        this.msg = msg
        this.redirect = redirect
        this.error = err
        Error.call this, msg
        Error.captureStackTrace this, arguments.callee
    u.DBError.prototype.__proto__ = Error.prototype
