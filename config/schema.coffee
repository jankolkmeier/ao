module.exports = (settings) ->
    orm      = require 'mongoose'
    Schema = orm.Schema
    ObjectId = orm.Schema.ObjectId

    User = new Schema {
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

    Chore = new Schema {
        name  : {
            type : String
            unique : true
        }
    }

    Log = new Schema {
        chore : {
            type : ObjectId
            required : true
        }
        user  : {
            type : ObjectId
            required : true
        }
        date  : {
            type : Date,
            default : Date.now
            required : true
        }
    }

    orm.connect 'mongodb://localhost/'+settings.maindb

    orm.model 'User', User
    this.User = orm.model('User')

    orm.model 'Chore', Chore
    this.Chore = orm.model('Chore')

    orm.model 'Log', Log
    this.Log = orm.model('Log')
    return this
