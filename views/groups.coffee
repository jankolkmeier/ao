h1 -> "Groups"
a href:"/groups/new", ->
    span -> "Add Group"
ul ->
    for group in @groups
        li ->
            h3 -> "#{group.name}"
            a href:"/group/#{group.id}", class:'button', ->
                span -> 'Details'
