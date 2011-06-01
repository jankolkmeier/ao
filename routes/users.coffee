module.exports = (web, db, u) ->
    crypto  = require('crypto')

    web.get '/users', (req, res, next) ->
        u.getAll 'users', (users) ->
            res.render 'users', context :
                users : users

    web.get '/user/:id', (req, res, next) ->
        u.findUser req.params.id, next, (user) ->
            res.render 'user', context :
                user : user

    web.get '/login', (req, res) ->
        res.render 'login', context:
            redirect: req.query.redirect

    web.post '/login', (req, res) ->
        pass = crypto.createHash('md5').update(req.body.pass).digest('hex')
        cb = () ->
            if not req.session.user
                res.redirect '/login?redirect='+req.query.redirect
        db.users.forEach cb, (key, user) ->
            if user.nick == req.body.nick and user.pass == pass
                req.session.user = user
                res.redirect req.query.redirect

    web.get '/logout', (req, res) ->
        delete req.session.user
        res.redirect req.query.redirect or '/'

    web.get '/register', (req, res) ->
        res.render 'register', context:
            redirect: req.query.redirect

    web.post '/register', (req, res, next) ->
        pass = crypto.createHash('md5').update(req.body.pass).digest('hex')
        newUser =
            name  : req.body.name
            nick  : req.body.nick
            pass  : pass
            mail  : req.body.mail
            id    : db.genKey()
        db.users.set newUser.id, newUser, (err) ->
            if err and err.name == 'ValidationError'
                return res.render 'register', context :
                    error: err
            return next new u.DBError("Can't save User", '/chores/new') if err
            req.session.user = newUser
            console.log(newUser)
            res.redirect req.query.redirect
