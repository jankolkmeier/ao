h1 -> "Welcome"
div ->
    if @user
        span "User: #{@user.name} "
        a href:'/logout', class:'small', -> "Logout"
    else
        span ->
            a href:'/login', -> "Login"
            span " "
            a href:'/register', -> "Register"
a href:'/chores', ->
    span 'Chores'
a href:'/Users', ->
    span 'Users'
h2 -> "Logs"
ul ->
    for log in @logs
        li ->
            span class:'user', -> "#{log.user?.name}"
            span " did "
            span class:'chore', -> "#{log.chore?.name}"
            span " for "
            span class:'hedon', -> "#{log.log?.hedons}"
            span " Hedons and "
            span class:'collecton', -> "#{log.log?.collectons}"
            span " Collectons"
