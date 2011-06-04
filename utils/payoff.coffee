# Payoff Calculations
module.exports = (u, db) ->
    u._getPayoff = (user, chore, cb) ->
        hedons = 50
        collectons = if chore.impact == 'individual' then 10 else 80
        cb null, hedons, collectons, chore

    u.getPayoff = (user, chore, cb) ->
        u.findUser user, false, (_user) ->
            u.findChore chore, false, (_chore) ->
                if user and chore
                    u._getPayoff _user, _chore, cb
                else
                    cb true
    console.log "loaded Payoff"
