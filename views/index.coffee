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
            ul ->
                if @conflicts and @conflicts.length > 0
                    for conflict in @conflicts
                        dEnd = new Date(conflict.end)
                        li ->
                            "Conflict #{conflict.chore.name} ending on #{dEnd.toLocaleDateString()} at #{dEnd.toLocaleTimeString()}"
                else
                    li ->
                        "No active conflicts!"
            h3 "Latest Events"
            ul ->
                for log in @logs
                    if log.log.eventtype == "progress" or log.log.eventtype == "conflict_solved"
                        li ->
                            span class:'user', -> "#{log.user?.name}"
                            span " did "
                            span class:'chore', -> "#{log.chore?.name}"
                            span " for "
                            span class:'hedon', -> "#{log.log?.hedons}"
                            span " Hedons and "
                            span class:'collecton', -> "#{log.log?.collectons}"
                            span " Collectons"
        div class:'center', ->
            a href:'/chores', ->
                span 'Chores'
            a href:'/Users', ->
                span 'Users'
            a href:'/groups', ->
                span 'Groups'
            a href:'/logout', -> "Logout"
    else
        div class:'center', ->
            a href:'/login', -> "Login"
            a href:'/register', -> "Register"
