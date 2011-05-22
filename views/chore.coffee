h1 -> "Chore Details"
h2 -> "#{@chore.name}"
a href:"/chores/edit/#{@chore.id}", class:'blue', ->
    span 'Edit chore'
a href:"/chores/do/#{@chore.id}", class:'orange', ->
    span 'Do chore'
div ->
    a href:"/chores", -> "View all chores"
