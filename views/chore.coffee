h1 -> "Chore Details"
h2 -> "#{@chore.name}"
div "Impact: #{@chore?.impact}"
div "Occurence: #{@chore?.occurence}"
div "Quest: #{@chore?.quest}"
a href:"/chores/edit/#{@chore.id}", class:'blue', ->
    span 'Edit chore'
a href:"/chores/do/#{@chore.id}", class:'orange', ->
    span 'Do chore'
div ->
    a href:"/chores", -> "View all chores"
