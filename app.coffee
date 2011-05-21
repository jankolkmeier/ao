express   = require('express')
settings  = require('./config/settings.coffee')
db        = require('./config/schema.coffee')(settings)
h         = require('./helper.coffee')(db)
web       = module.exports = express.createServer()

require('./config/environment.coffee')(web, express, settings)

require('./routes/main.coffee')(web, db, h)
require('./routes/users.coffee')(web, db, h)
require('./routes/chores.coffee')(web, db, h)

web.listen settings.httpPort
