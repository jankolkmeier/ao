module.exports = (web, express, settings) ->
    Session = require 'connect-mongodb'
    web.register '.coffee',       require 'coffeekup'
    web.set      'view engine',   'coffee'
    web.set      'views',         __dirname + '/../views'
    web.use      express.static   __dirname + '/../static'
    web.use      express.bodyParser()
    web.use      express.cookieParser()
    web.use      express.session {
        cookie : {
            maxAge : 60000 * 60 * 24 * 14
            path   : '/'
        }
        secret : settings.sessionsecret,
        store  : new Session({
            dbname : settings.dbname
        })
    }
