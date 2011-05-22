module.exports = (web, db, u) ->
    crypto  = require('crypto')

    web.get '/users', (req, res, next) ->
        db.User.find {}, (err, docs) ->
            return next new u.DBError("Can't get Users", '/users', err) if err
            res.render 'users', context :
                users : docs

    web.get '/user/:id', (req, res, next) ->
        u.findUser req.params.id, next, (user) ->
            res.render 'user', context :
                user : user

    web.get '/login', (req, res) ->
        res.render 'login', context:
            redirect: req.query.redirect

    web.post '/login', (req, res) ->
        pass = crypto.createHash('md5').update(req.body.pass).digest('hex')
        db.User.find 
            'nick' : req.body.nick
            'pass' : pass
            (err, docs) ->
                if docs.length == 1
                    req.session.user = docs[0]
                    res.redirect req.query.redirect
                else
                    res.redirect '/login?redirect='+req.query.redirect

    web.get '/logout', (req, res) ->
        delete req.session.user
        res.redirect req.query.redirect or '/'

    web.get '/register', (req, res) ->
        res.render 'register', context:
            redirect: req.query.redirect

    web.post '/register', (req, res, next) ->
        pass = crypto.createHash('md5').update(req.body.pass).digest('hex')
        newUser = new db.User
            name  : req.body.name
            nick  : req.body.nick
            pass  : pass
            mail  : req.body.mail
        newUser.save (err) ->
            if err and err.name == 'ValidationError'
                return res.render 'register', context :
                    error: err
            return next new u.DBError("Can't save User", '/chores/new') if err
            req.session.user = newUser
            res.redirect req.query.redirect
