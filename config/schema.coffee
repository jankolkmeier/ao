module.exports = (settings) ->
    orm      = require 'mongoose'
    Schema = orm.Schema
    ObjectId = orm.Schema.ObjectId
    
    orm.connect 'mongodb://localhost/'+settings.dbname

    GroupSchema = new Schema
        name :
            type : String
            required : true
            
    orm.model 'Group', GroupSchema
    this.Group = orm.model 'Group'

    UserSchema = new Schema
        nick :
            type : String
            unique : true
            required : true
            index : true
        name :
            type : String
            required : true
        mail :
            type : String
            unique : true
            required : true
        pass :
            type : String
            required : true
        group :
            type : ObjectId

    orm.model 'User', UserSchema
    this.User = orm.model 'User'

    Param = new Schema
        name : String
        value : String

    ChoreSchema = new Schema
        name :
            type : String
            unique : true
        desc :
            type : String
        impact :
            type : String
            enum : ['individual', 'group']
        occurence :
            type : String
            enum : ['random', 'fixed', 'onetime']
        group :
            type : ObjectId
        progress :
            type : String
        conflict :
            type : String
        params : [Param]

    orm.model 'Chore', ChoreSchema
    this.Chore = orm.model 'Chore'

    ConflictSchema = new Schema
        choreid :
            type : ObjectId
        group :
            type : ObjectId
        conflict :
            type : String
        start :
            type : Date,
            required : true
        end :
            type : Date,
            required : true
        params : [Param]

    orm.model 'Conflict', ConflictSchema
    this.Conflict = orm.model 'Conflict'

    LogSchema = new Schema
        event :
            type : String
            enum : [
                'progress' # H, C, user, chore, group
                'conflict_start' # conflict, chore, group
                'conflict_solved' # H, C, conflict, chore, user, group 
                'conflict_unsolved' # H, C, conflict, group
            ]
        groupid :
            type : ObjectId
            required : true
        date :
            type : Date,
            default : Date.now
            required : true
        userid :
            type : ObjectId
        choreid :
            type : ObjectId
        conflictid :
            type : ObjectId
        hedons :
            type : Number
            default : 0
        collectons :
            type : Number
            default : 0

    orm.model 'Log', LogSchema
    this.Log = orm.model 'Log'


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
