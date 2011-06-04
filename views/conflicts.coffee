h1 -> "Conflicts"
ul ->
    for conflict in @conflicts
        li ->
            h3 -> "#{conflict.desc}"
            a href:"/conflict/#{conflict.id}", ->
                span -> 'Details'
