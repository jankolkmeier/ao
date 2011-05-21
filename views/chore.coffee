h1 -> "Chore Details"
h2 -> "#{@chore.name}"
a href:"/chores/edit/#{@chore.id}", ->
    span -> 'Edit Chore'
a href:"/chores/do/#{@chore.id}", ->
    span -> 'Do Chore'

