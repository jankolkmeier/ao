exports.authed = (req, res) ->
    if not req.session.user
        res.redirect '/login?redirect='+req.url
        return false
    return true

# Exceptions
exports.NotFound = (msg) ->
    this.name = 'NotFound'
    Error.call this, msg
    Error.captureStackTrace this, arguments.callee

exports.NotFound.prototype.__proto__ = Error.prototype
