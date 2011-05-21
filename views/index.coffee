h1 -> "Welcome"
p -> "User: #{@user?.name or '--'}"
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

