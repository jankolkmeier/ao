express   = require('express')
settings  = require('./config/settings.coffee')
dirty     = require('./node-dirty/lib/dirty/index.js')
db        = require('./config/schema.coffee')(settings, dirty)
web       = module.exports = express.createServer()

require('./config/environment.coffee')(web, express, settings)

utils     = require('./utils/index.coffee')(db, settings, [
        'errors'
        'dbhelper'
        'scenarios'
        'conflicts'
        'payoff'
        'notifier'
    ])
 
for route in ['main', 'users', 'chores', 'conflicts', 'groups', 'api', 'settings']
    require('./routes/'+route+'.coffee')(web, db, utils)

web.listen settings.httpPort, utils.loadScenario
