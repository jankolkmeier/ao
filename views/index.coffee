h2 -> "Welcome"
p -> "User: #{@user?.name or '--'}"
a href:'/chores', ->
    span -> 'Chores'
span -> " "
a href:'/Users', ->
    span -> 'Users'
