h1 -> "Users"
ul ->
    for user in @users
        li ->
            h3 -> "#{user.name}"
            a class:'button', href:"/user/#{user.id}", ->
                span -> 'Details'
