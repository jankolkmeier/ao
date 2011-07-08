h1 -> "Conflict Details"
h2 -> "#{@conflict.desc}"

a href:"/chore/#{@conflict.choreid}", class:'orange', ->
    span 'View connected chore'

div ->
    a href:"/conflicts", -> "View all conflicts"
