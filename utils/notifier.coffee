# (Email) notifiers
module.exports = (u, db) ->
    email = require 'mailer'
    settings  = require('../config/settings.coffee')

    u.sendMail = (subject, body, recipients) ->
        emailSetup =
            host : settings.mailHost
            port : settings.mailPort
            domain : settings.mailDomain
            ssl : settings.mailSSL
            to : ""
            from : settings.mailFrom
            subject : subject
            body : body
            authentication : "login"
            username : settings.mailUser
            password : settings.mailPass
        for to in recipients
            emailSetup.to = to
            email.send emailSetup, (err, res) ->
                if err
                    console.log "MAIL ERROR: "
                    console.log err

    console.log "Loaded Notifier"
