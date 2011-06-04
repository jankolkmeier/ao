# Conflict helpers
module.exports = (u, db, settings) ->
    u.checkRunningConflicts = (choreid, cb) ->
        u.getRunningConflicts choreid, (conflicts) ->
            cb conflicts

    u.conflictOverlap = (c1, cb) ->
        res = false
        done = () ->
            cb(res)
        console.log "c1.start: "+c1.start+" | c1.end: "+c1.end
        db.conflicts.forEach done, (key, c2) ->
            console.log "c2.start: "+c2.start+" | c2.end: "+c2.end
            same = c1.choreid == c2.choreid
            overlap = (c1.start <= c2.end) and (c2.start <= c1.end)
            if same and overlap
                res = true


    u.getRunningConflicts = (choreid, cb) ->
        res = []
        now = Date.now()
        done = () ->
            cb(res)
        db.conflicts.forEach done, (key, conflict) ->
            running = conflict.start < now and conflict.end > now
            running = running and not conflict.ended
            related = (choreid and choreid == conflict.choreid) or not choreid
            if running and related
                res.push conflict

    u.endUnsolvedConflicts = () ->
        now = Date.now()
        done = () ->
            console.log "#"
        db.conflicts.forEach done, (key, conflict) ->
            if (not conflict.ended) and conflict.end < now
                conflict.ended = true
                db.conflicts.set conflict.id, conflict, () ->
                    newLog =
                        eventtype : 'conflict_unsolved'
                        conflictid : conflict.id
                        date : now
                        id : db.genKey()
                    console.log "Conflict unsolved: "+conflict.scene+" "+now
                    db.logs.set newLog.id, newLog

    u.conflictWorker = null

    u.startConflictWorker = () ->
        clearInterval(u.conflictworker) if u.conflictWorker != null
        u.conflictWorker = setInterval u.endUnsolvedConflicts, 1000*10

    u.startConflictWorker()
