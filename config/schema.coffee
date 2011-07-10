module.exports = (settings, db) ->
    # Currently a plain key-value storage is used (node-dirty),
    # so there is no need for a schema. Could change in future.
    this.users = db 'data/users.db'
    this.groups = db 'data/groups.db'
    this.chores = db 'data/chores.db'
    this.conflicts = db 'data/conflicts.db'
    this.logs = db 'data/logs.db'


    console.log "loaded Schema"
    return this
