module.exports = (web, db, h) ->
    crypto  = require('crypto')

    web.get '/users', (req, res, next) ->
        db.User.find {}, (err, docs) ->
            return next new h.DBError("Can't save Chore", '/chores/new', err) if err
            res.render 'chores', context : { chores : docs }

    web.get '/user/:id', (req, res, next) ->
        findChore req.params.id, next, (chore) ->
            res.render 'chore', context : { chore : chore }

    web.get '/login', (req, res) ->
        res.render 'login', context: { redirect: req.query.redirect }

    web.post '/login', (req, res) ->
        pass = crypto.createHash('md5').update(req.body.pass).digest('hex')
        db.User.find { nick : req.body.nick, pass : pass }, (err, docs) ->
            if docs.length == 1
                req.session.user = docs[0]
            res.redirect req.query.redirect

    web.get '/logout', (req, res) ->
        delete req.session.user
        res.redirect req.query.redirect or '/'

    web.get '/register', (req, res) ->
        res.render 'register', context: { redirect: req.query.redirect }

    web.post '/register', (req, res, next) ->
        pass = crypto.createHash('md5').update(req.body.pass).digest('hex')
        newUser = new db.User {
            name  : req.body.name
            nick  : req.body.nick
            pass  : pass
            mail  : req.body.mail
        }
        newUser.save (err) ->
            if err and err.name == 'ValidationError'
                return res.render 'register', context : { error: err }
            return next new h.DBError("Can't save User", '/chores/new') if err
            req.session.user = newUser
            res.redirect req.query.redirect
