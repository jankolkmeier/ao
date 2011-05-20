exports.authed = (req, res) ->
    if not req.session.user
        res.redirect '/login?redirect='+req.url
        return false
    return true
