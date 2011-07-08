div id:'top', ->
    if @user
        h1 -> "DASHBOARD"
        h2 -> "#{@user.name} (#{@user.nick})"
    else
        h1 -> "WELCOME"
        h2 -> "Unknown user"
div ->
    if @user
        div class:'box', ->
            h3 "Active Conflicts"
            if @conflicts and @conflicts.length > 0
                ul class:"events", ->
                    for conflict in @conflicts
                        dEnd = new Date(conflict.end)
                        li class:"conflict #{conflict.impact}", ->
                            if conflict.user
                                user = conflict.user.name+" is"
                                if conflict.userid == @user.id
                                    user = "You are"
                                a href:"/chore/#{conflict.chore.id}", ->
                                    span "#{user} in a conflict. To solve it, chore <em>#{conflict.chore.name}</em> has to be done before #{dEnd.toLocaleTimeString()}."
                            else
                                a href:"/chore/#{conflict.chore.id}", ->
                                    span "The whole group is in a conflict. To solve it, someone has to do the chore <em>#{conflict.chore.name}</em> before #{dEnd.toLocaleTimeString()}!"
            else
                li ->
                    "No active conflicts!"
            h3 "Latest Events"
            ul class:"events", ->
                index = 0
                for key,log of @logs
                    if index >= 5
                        break
                    if log.log.eventtype == "progress" or log.log.eventtype == "conflict_solved"
                        index++
                        li class:"#{log.log.impact}", ->
                            span class:'user', -> "#{log.user?.name}"
                            span " did "
                            span class:'chore', -> "#{log.chore?.name}"
                            span " for "
                            span class:'hedon', -> "#{log.log?.hedons}"
                            span " Hedons and "
                            span class:'collecton', -> "#{log.log?.collectons}"
                            span " Collectons"
        div class:'center', ->
            a class:'button', href:'/chores', ->
                span 'Chores'
            a class:'button', href:'/Users', ->
                span 'Users'
            a class:'button', href:'/groups', ->
                span 'Groups'
            a class:'button', href:'/logout', -> "Logout"
    else
        div class:'center', ->
            a class:'button', href:'/login', -> "Login"
            a class:'button', href:'/register', -> "Register"
