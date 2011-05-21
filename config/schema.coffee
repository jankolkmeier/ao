module.exports = (settings) ->
    orm      = require 'mongoose'
    Schema = orm.Schema
    ObjectId = orm.Schema.ObjectId
    
    orm.connect 'mongodb://localhost/'+settings.dbname

    UserSchema = new Schema {
        nick  : {
            type : String
            unique : true
            required : true
            index : true
        }
        name  : {
            type : String
            required : true
        }
        mail  : {
            type : String
            unique : true
            required : true
        }
        pass  : {
            type : String
            required : true
        }
    }

    orm.model 'User', UserSchema
    this.User = orm.model('User')


    ChoreSchema = new Schema {
        name  : {
            type : String
            unique : true
        }
    }

    orm.model 'Chore', ChoreSchema
    this.Chore = orm.model('Chore')


    LogSchema = new Schema {
        choreid : {
            type : ObjectId
            required : true
        }
        userid  : {
            type : ObjectId
            required : true
        }
        date  : {
            type : Date,
            default : Date.now
            required : true
        }
    }

    orm.model 'Log', LogSchema
    this.Log = orm.model('Log')


    return this
