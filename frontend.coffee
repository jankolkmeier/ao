express   = require('express')
settings  = require('./config/settings.coffee')
db        = require('./config/schema.coffee')(settings)
web       = module.exports = express.createServer()
require('./config/environment.coffee')(web, express, settings)

utils     = require('./utils/index.coffee')(db, [
        'errors'
        'dbhelper'
        'scenarios'
        'payoff'
    ])
 
require('./routes/main.coffee')(web, db, utils)
require('./routes/users.coffee')(web, db, utils)
require('./routes/chores.coffee')(web, db, utils)
require('./routes/groups.coffee')(web, db, utils)

web.listen settings.httpPort
