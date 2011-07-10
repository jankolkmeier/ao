# Payoff Calculations
module.exports = (u, db) ->
    u._getPayoff = (user, chore, cb) ->
        hedons = 50
        collectons = 10
        u.calculateChorePayoffMatrix chore.id, (matrix) ->
            if chore.impact == 'individual'
                collectons = 10
            else
                collectons = matrix[user.id]
            console.log matrix
            cb null, hedons, collectons, chore

    u.calculateChorePayoffMatrix = (choreid, cb) ->
        u.findSettings 'settings', false, (settings) ->
            matrix = {}
            u.findChore choreid, false, (chore) ->
                u.getUsers chore.groupid, (users) ->
                    console.log users.length
                    for userid in users
                        matrix[userid] = 0
                        u.getLogsByUser userid, choreid, (logs) ->
                            for log in logs
                                matrix[userid] += 1*settings.payoffDegradationPerDay
                    console.log matrix
                    cb(u.normalizeMatrix(matrix))

    u.normalizeMatrix = (matrix) ->
        max = 0
        min = Infinity
        for userid,count of matrix
            if count > max
                max = count
            if count < min
                min = count
        range = max - min
        for userid,count of matrix
            if range == 0
                matrix[userid] = 100
            else
                matrix[userid] = 100 - parseInt(100 * (count-min)/range)
        return matrix

    u.getUsers = (groupid, cb) ->
        res = []
        done = () ->
            cb(res)
        db.users.forEach done, (key, user) ->
            if user.groupid == groupid
                res.push(user.id)

    u.getLogsByUser = (userid, choreid, cb) ->
        res = []
        done = () ->
            cb(res)
        db.logs.forEach done, (key, log) ->
            if log.userid == userid and (log.choreid == choreid || choreid == false)
                res.push(log)

    u.getPayoff = (user, chore, cb) ->
        u.findUser user, false, (_user) ->
            u.findChore chore, false, (_chore) ->
                if user and chore
                    u._getPayoff _user, _chore, cb
                else
                    cb true

    console.log "loaded Payoff"
