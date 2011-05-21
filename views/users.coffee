h1 -> "Users"
ul ->
    for user in @users
        li ->
            h3 -> "#{user.name}"
            a href:"/user/#{user.id}", ->
                span -> 'Details'
