module.exports = (web, db, u) ->
    web.get '/logs/:since', (req, res, next) ->
        logs = []
        cbdone = () ->
            res.send { logs:logs }
        db.logs.forEach cbdone, (key, val) ->
            if val.date>parseInt(req.params.since)
                logs.push val
