express   = require('express')
settings  = require('./config/settings.coffee')
helper    = require('./helper.coffee')
db        = require('./config/schema.coffee')(settings)
web       = module.exports = express.createServer()
require('./config/environment.coffee')(web, express, settings)

require('./routes/main.coffee')(web, db, helper)
require('./routes/chores.coffee')(web, db, helper)

app.error (err, req, res, next) ->
    if err instanceof helper.NotFound
        return res.render '404'
    next err

web.listen settings.httpPort
