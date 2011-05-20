express   = require('express')
settings  = require('./config/settings.coffee')
helper    = require('./helper.coffee')
db        = require('./config/schema.coffee')(settings)
web       = module.exports = express.createServer()
require('./config/environment.coffee')(web, express, settings)

require('./routes/main.coffee')(web, db, helper)

web.listen settings.httpPort
