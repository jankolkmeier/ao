h1 -> "Chore Details"
h2 -> "#{@chore.name}"
div "Impact: #{@chore?.impact}"
div "Occurence: #{@chore?.occurence}"
for type in ['progress', 'conflict']
    div "#{type}: #{@chore?[type]}"
    for param in @chore[type+'_params']
        div "#{param.name}: #{param.value}"

a href:"/chores/edit/#{@chore.id}", class:'blue', ->
    span 'Edit chore'
a href:"/chores/do/#{@chore.id}", class:'orange', ->
    span 'Do chore'
div ->
    a href:"/chores", -> "View all chores"
