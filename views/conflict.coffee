h1 -> "Conflict Details"
h2 -> "#{@conflict.desc}"

a href:"/chores/do/#{@conflict.choreid}", class:'orange', ->
    span 'Do chore'

div ->
    a href:"/conflicts", -> "View all conflicts"
