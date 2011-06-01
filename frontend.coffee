express   = require('express')
settings  = require('./config/settings.coffee')
nstore        = require('./node-dirty/lib/dirty/index.js')
db        = require('./config/schema.coffee')(settings, nstore)
web       = module.exports = express.createServer()
require('./config/environment.coffee')(web, express, settings)

utils     = require('./utils/index.coffee')(db, settings, [
        'errors'
        'dbhelper'
        'scenarios'
        'payoff'
    ])
 
require('./routes/main.coffee')(web, db, utils)
require('./routes/users.coffee')(web, db, utils)
require('./routes/chores.coffee')(web, db, utils)
require('./routes/groups.coffee')(web, db, utils)

web.listen settings.httpPort, utils.loadScenario
