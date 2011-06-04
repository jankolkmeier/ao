h1 -> "Conflicts"
ul ->
    for conflict in @conflicts
        if not conflict.ended
            li ->
                h3 -> "#{conflict.desc}"
                a href:"/conflict/#{conflict.id}", ->
                    span -> 'Details'
