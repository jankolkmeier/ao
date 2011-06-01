h1 -> "Chores"
a href:"/chores/new", ->
    span -> "Add Chore"
ul ->
    for chore in @chores
        li ->
            h3 -> "#{chore.name}"
            a href:"/chore/#{chore.id}", ->
                span -> 'Details'
