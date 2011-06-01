module.exports = (web, express, settings) ->
    #Session = express.session.MemoryStore
    Session = require('../connect-dirty/index.js')
    web.register '.coffee',       require 'coffeekup'
    web.set      'view engine',   'coffee'
    web.set      'views',         __dirname + '/../views'
    web.use      express.static   __dirname + '/../static'
    web.use      express.bodyParser()
    web.use      express.cookieParser()
    web.use      express.session
        key    : 'ao.sid'
        cookie :
            maxAge : 60000 * 60 * 24 * 14
            path   : '/'
        secret : settings.sessionsecret,
        store  : new Session()
