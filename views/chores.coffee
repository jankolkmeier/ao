qr = "http://chart.apis.google.com/chart?cht=qr&chs=400x400&choe=UTF-8&chl="
location = "http://ewi1544.ewi.utwente.nl:5500/chore/"
div id:'top', ->
    h1 -> "Manage Chores"
    h2 -> "Tip: check out the 'QR' links!"
a href:"/chores/new", class:'blue button', -> "Add Chore"
for chore in @chores
    div class:"box", ->
        h1 -> "#{chore.name}"
        h2 -> "#{chore.desc}"
        div class:'right', ->
            a href:"/chore/#{chore.id}", class:'button small', ->
                span -> 'Details'
            a href:"/chores/edit/#{chore.id}", class:'blue button small', ->
                span 'Edit'
            a href:qr+location+chore.id, class:'yellow button small', -> "QR"
