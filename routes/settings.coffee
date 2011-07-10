module.exports = (web, db, u) ->
    web.get '/settings', (req, res, next) ->
        try
            u.findSettings 'settings', next, (settings) ->
                res.render 'settings', context:
                    settings : settings
        catch Error
            db.settings.set 'settings', {}, () ->
                res.redirect '/settings'


    web.post '/settings/save', (req, res, next) ->
        settings = {}
        # Parse regular input
        for k,v of req.body
            if k == 'mailPort'
                v = parseInt(v)
            if k == 'payoffDegradationPerDay'
                v = parseFloat(v)
            settings[k] = v
        # Parse Checkboxes
        for key in ['mailSSL']
            if req.body[key]
                settings[key] = true
            else
                settings[key] = false
        db.settings.set 'settings', settings, () ->
            res.redirect '/settings'
