module.exports = (db, load) ->

    for module in load
        require('./'+module+'.coffee')(this, db)
    
    # Some general helpers
    this.authed = (req, res) ->
        if not req.session.user
            res.redirect '/login?redirect='+req.url
            return false
        return true

    return this
