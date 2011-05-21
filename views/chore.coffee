h1 -> "View Chore"
h2 -> "#{@chore.name}"
a href:"/chores/edit/#{@chore.id}", ->
    span -> 'Edit Chore'
if @error?.errors?.name
    div class:'error', -> "Name invalid"
