h1 -> "Welcome"
div -> 
    if @user
        span "User: #{@user.name} "
        a href:'/logout', -> "Logout"
    else
        span ->
            a href:'/login', -> "Login"
            span " "
            a href:'/register', -> "Register"
a href:'/chores', ->
    span -> 'Chores'
span -> " "
a href:'/Users', ->
    span -> 'Users'
h2 -> "Logs"
ul ->
    for log in @logs
        li ->
            span -> "#{log.user.name}"
            span -> " did "
            span -> "#{log.chore.name}"
