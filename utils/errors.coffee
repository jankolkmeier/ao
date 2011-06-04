# Exceptions
module.exports = (u, db) ->
    u.Err = (msg, redirect) ->
        this.name = 'Error'
        this.msg = msg
        this.redirect = redirect
        Error.call this, msg
        Error.captureStackTrace this, arguments.callee
    u.Err.prototype.__proto__ = Error.prototype

    console.log "loaded Errors"
