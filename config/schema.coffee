module.exports = (settings, db) ->

    this.users = db 'data/users.db'
    this.groups = db 'data/groups.db'
    this.chores = db 'data/chores.db'
    this.logs = db 'data/logs.db'

    this.genKey = () ->
        return (0x2000000000 * Math.random() + (Date.now() & 0x1f)).toString(32)

    console.log "loaded Schema"
    return this

# Validator stuff:
#
#
# ...
# 
# random + group : group_progress
# random + individual : individual_progress
#
# fixed + group : group_progess, group_conflict
# fixed + individual : individual_progress, individual_conflict
#
# once + group : group_progess, group_conflict
# once + individual : individual_progress, individual_conflict
